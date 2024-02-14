class AdminsController < ApplicationController
  def index
    @products = Product.all
  end
end
