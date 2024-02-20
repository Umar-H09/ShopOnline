class AdminsController < ApplicationController
  def index
    @products = current_user.products
  end
end
