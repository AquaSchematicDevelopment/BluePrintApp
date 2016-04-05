class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.decimal :book_value, precision: 12, scale: 4
      t.integer :season_id

      t.timestamps null: false
    end
    add_index :teams, :season_id
  end
end
