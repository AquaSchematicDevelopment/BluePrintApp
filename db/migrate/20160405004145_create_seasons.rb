class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :league_id
      t.string :name

      t.timestamps null: false
    end
  end
end
