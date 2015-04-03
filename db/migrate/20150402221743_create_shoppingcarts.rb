class CreateShoppingcarts < ActiveRecord::Migration
  def change
    create_table :shoppingcarts do |t|
      t.integer :size
      t.decimal :total
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :shoppingcarts, :users
  	add_index :shoppingcarts, [:user_id, :created_at]
  end
end
