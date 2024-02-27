class OrdersController < ApplicationController
  layout "admin", except: [:new]
  def index
    @orders = if current_user.has_role? :User
                current_user.orders
              else
                Order.joins(orderables: :product).where(products: { id: current_user.product_ids })
              end
  end

  def show
    @order = Order.find_by(id: params[:id])
    @orderables = @order.orderables
  end

  def new
    @order = Order.new
  end

  def create
    if current_user
      @user = current_user
    else
      @user = User.new(user_params)
      if user_params[:password].blank?
        @user.skip_password_validation = true
      end
      @user.save
    end
    @order = @user.orders.new(order_params)
    if @order.save
      @cart.orderables.each do |orderable|
        product = orderable.product
        new_quantity = product.quantity - orderable.quantity
        product.update(quantity: new_quantity)
      end  
      @cart.order = @order
      session[:cart_id] = nil if @cart.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find_by(id: params[:id])
  end

  def update
    @order = Order.find_by(id: params[:id]) 
    if @order.update(order_params)
      redirect_to orders_path
    else
      render :edit , status: :unprocessable_entity
    end 
  end

  def add
      @product = Product.find_by(id: params[:id])
      quantity = params[:quantity].to_i
      current_orderable = @cart.orderables.find_by(product_id: @product.id)
      if current_orderable && quantity > 0 
        if @product.quantity >= quantity
          current_orderable.update(quantity:)
        else
          flash.now[:alert] = "Oops! We have only #{@product.quantity} pieces left in stock "
        end
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
    params.require(:order).permit(:adress, :phone_number, :status, :country, :state, :city, :area, :zip_code)
  end

  def user_params
    params.require(:order).permit(:username, :email, :password, :password_confirmation)
  end
end
