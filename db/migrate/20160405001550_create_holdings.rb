class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.integer :portfolio_id
      t.integer :team_id
      t.integer :blue_prints

      t.timestamps null: false
    end
    add_index :holdings, :portfolio_id
    add_index :holdings, :team_id
  end
end
