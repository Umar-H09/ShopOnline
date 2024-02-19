class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price, precision: 5, scale: 2
      t.text :description
      t.integer :quantity
      t.references :categories

      t.timestamps
    end
  end
end
