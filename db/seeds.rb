# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# ActiveRecord::Base.transaction do
#     10.times do |i| 
#         user = User.create(
#             email: Faker::Internet.email,
#             password: 'password',
            
#         )
#     end
# end

%w[Admin Vendor User].each do |role|
    role = Role.where(name: role).first_or_initialize
    role.save
end
user = User.where(email: "umar@gmail.com").first_or_initialize
user.username = "Umar"
user.password = 'Qwerty1!'
user.add_role(:Admin)
user.save