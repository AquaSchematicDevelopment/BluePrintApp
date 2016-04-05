class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :league_id
      t.decimal :value, precision: 12, scale: 4

      t.timestamps null: false
    end
    add_index :teams, :league_id
  end
end
