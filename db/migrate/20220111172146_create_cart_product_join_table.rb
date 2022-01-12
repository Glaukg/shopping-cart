class CreateCartProductJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :carts, :products
  end
end
