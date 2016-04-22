class CreateSellRequests < ActiveRecord::Migration
  def change
    create_table :sell_requests do |t|
      t.integer :portfolio_id
      t.integer :team_id
      
      t.decimal :price, precision: 12, scale: 4
      t.integer :amount

      t.timestamps null: false
    end
    add_index :sell_requests, :portfolio_id
    add_index :sell_requests, :team_id
  end
end
