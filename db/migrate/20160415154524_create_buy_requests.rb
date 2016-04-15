class CreateBuyRequests < ActiveRecord::Migration
  def change
    create_table :buy_requests do |t|
      t.integer :portfolio_id
      t.integer :team_id
      
      t.integer :amount
      t.decimal :price

      t.timestamps null: false
    end
    add_index :buy_requests, :portfolio_id
    add_index :buy_requests, :team_id
  end
end
