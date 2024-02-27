class AdminsController < ApplicationController
  layout 'admin'
  def index
    @products = current_user.products
    @orders = if current_user.has_role? :User
      current_user.orders
    else
      Order.joins(orderables: :product).where(products: { id: current_user.product_ids })
    end
    @user = User.with_role :Vendor
  end
end
