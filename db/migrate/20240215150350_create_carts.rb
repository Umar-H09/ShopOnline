class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :orders, null: true, foreign_key: true

      t.timestamps
    end
  end
end
