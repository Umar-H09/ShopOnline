class Product < ApplicationRecord
    has_one_attached :avatar
    
    has_many :orderables
    has_many :carts, through: :orderables
    belongs_to :user

    validates :title, presence: true
    validates :price, presence: true
    validates :description, presence: true
    validates :quantity, presence: true
    validates :avatar, presence: true
end
