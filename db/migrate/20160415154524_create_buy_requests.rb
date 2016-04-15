class CreateBuyRequests < ActiveRecord::Migration
  def change
    create_table :buy_requests do |t|
      t.integer :amount
      t.decimal :price

      t.timestamps null: false
    end
  end
end
