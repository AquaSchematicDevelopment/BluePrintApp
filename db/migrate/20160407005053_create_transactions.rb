class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :price
      t.int :amount

      t.timestamps null: false
    end
  end
end
