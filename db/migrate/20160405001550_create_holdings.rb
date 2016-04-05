class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.integer :profolio_id
      t.integer :team_id
      t.decimal :blue_prints

      t.timestamps null: false
    end
  end
end
