class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.string :email, unique: true

      t.timestamps
    end
  end
end
