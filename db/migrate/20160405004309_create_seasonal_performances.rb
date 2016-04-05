class CreateSeasonalPerformances < ActiveRecord::Migration
  def change
    create_table :seasonal_performances do |t|
      t.decimal :book_value
      t.integer :team_id
      t.integer :season_id

      t.timestamps null: false
    end
  end
end
