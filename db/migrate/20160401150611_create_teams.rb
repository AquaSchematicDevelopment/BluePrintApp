class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :season_id

      t.timestamps null: false
    end
    add_index :teams, :season_id
  end
end
