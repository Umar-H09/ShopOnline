class Product < ApplicationRecord
    has_one_attached :avatar
    
    has_many :orderables
    has_many :carts, through: :orderables
    belongs_to :user
end
