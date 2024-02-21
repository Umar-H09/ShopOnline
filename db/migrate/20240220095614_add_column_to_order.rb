class AddColumnToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :country, :string
    add_column :orders, :state, :string
    add_column :orders, :city, :string
    add_column :orders, :area, :string
    add_column :orders, :zip_code, :integer
  end
end
