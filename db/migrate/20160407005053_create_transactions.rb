class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :from_portfolio
      t.integer :to_portfolio
      t.integer :team_id
      
      t.decimal :price
      t.integer :amount

      t.timestamps null: false
    end
    add_index :transactions, :team_id
  end
end
