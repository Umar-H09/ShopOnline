class User < ApplicationRecord
  rolify

  validates :email, presence: {message:"Email can't be blank"}, format: { with:  /([a-zA-Z\d\.-]+)@([a-zA-Z\d-]+)\.([a-zA-Z]{2,8})(\.(a-zA-Z){2,8})?/, message: "Invalid email format. Please enter it again." }, uniqueness:{message:"Email has already been taken"}
  validates :password, presence: {message:"Password can't be blank"},length:{minimum:6 , message:"Password is too short(minimum is 6 characters)"}, format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()])/, message: "Password include one lowercase, one uppercase and one special character" }
  validates :full_name, presence: { message: "Name can't be blank" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end



 