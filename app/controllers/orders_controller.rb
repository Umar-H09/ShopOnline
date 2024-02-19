class OrdersController < ApplicationController
  def index
   @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end
  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      @cart.order = @order
      session[:cart_id] = nil if @cart.save
      redirect_to root_path(@order)
      flash[:success] = "Your order has been placed!"
    else
    render 'new'
  end
end

  def add
    if user_signed_in?
      @product = Product.find_by(id: params[:id])
      quantity = params[:quantity].to_i
      current_orderable = @cart.orderables.find_by(product_id: @product.id)
      if current_orderable && quantity > 0
        current_orderable.update(quantity:)
      elsif quantity <= 0
        current_orderable.destroy
      else
        @cart.orderables.create(product: @product, quantity:)
      end
      
      respond_to do |format|
        format.turbo_stream do 
          render turbo_stream: [turbo_stream.replace('cart',
                                partial: 'partials/cart',
                                locals: { cart: @cart }),
                              ]
      end
    end
  
  else
    redirect_to new_user_session_path
 end
end

def remove
  Orderable.find_by(id: params[:id]).destroy
  respond_to do |format|
    format.turbo_stream do 
      render turbo_stream: [turbo_stream.replace('cart',
      partial: 'partials/cart',
      locals: { cart: @cart })
    ]
    end
 end
end


private
def order_params
  params.require(:order).permit(:adress, :phone_number, :status)
end
end