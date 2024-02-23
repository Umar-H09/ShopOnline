class Order < ApplicationRecord
    belongs_to :user
    has_one :cart
    has_many :orderables, through: :cart

    enum :status, [ :Pending, :Delivered ]
end






  