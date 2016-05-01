class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :league_id
      t.string :name
      t.string :status

      t.timestamps null: false
    end
  end
end
