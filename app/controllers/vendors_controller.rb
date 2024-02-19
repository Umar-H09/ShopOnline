class VendorsController < ApplicationController
  def index
   @user = User.with_role :Vendor

  end

  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
   
  end

  def create
    @user = User.new(vendor_params)
    @user.add_role :Vendor
    if @user.save
      redirect_to vendors_path(@user)
    else
      render 'new'
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(vendor_params)
      redirect_to vendors_path(@user)
    else
      render :edit , status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to vendors_path
  end

  private
    def vendor_params
      params.require(:user).permit(:username, :email, :password)
    end
end