class CreateSellRequests < ActiveRecord::Migration
  def change
    create_table :sell_requests do |t|
      t.decimal :price
      t.integer :amount

      t.timestamps null: false
    end
  end
end
