class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :sport_id

      t.timestamps null: false
    end
    add_index :leagues, :sport_id
  end
end
