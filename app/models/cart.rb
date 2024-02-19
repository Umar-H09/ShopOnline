class Cart < ApplicationRecord
  belongs_to :order, optional: true
  has_many :orderables
  has_many :products, through: :orderables

  def total
     orderables.to_a.sum { |orderable| orderable.total }
  end
end
