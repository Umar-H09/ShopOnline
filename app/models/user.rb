class User < ApplicationRecord
  rolify
  attr_accessor :skip_password_validation



  # validates :email, presence: {message:"Email can't be blank"}, format: { with:  /([a-zA-Z\d\.-]+)@([a-zA-Z\d-]+)\.([a-zA-Z]{2,8})(\.(a-zA-Z){2,8})?/, message: "Invalid email format. Please enter it again." }, uniqueness:{message:"Email has already been taken"}
  # validates :password, presence: {message:"Password can't be blank"},length:{minimum:6 , message:"Password is too short(minimum is 6 characters)"}, format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()])/, message: "Password include one lowercase, one uppercase and one special character" }
  # validates :username, presence: { message: "Name can't be blank" }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_many :products

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:User) if self.roles.blank?
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end

end



 