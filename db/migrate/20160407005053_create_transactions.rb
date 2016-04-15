class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :team_id
      
      t.decimal :price
      t.integer :amount

      t.timestamps null: false
    end
    add_index :transactions, :seller_id
    add_index :transactions, :buyer_id
    add_index :transactions, :team_id
  end
end
