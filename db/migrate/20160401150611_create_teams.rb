class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :sport_id

      t.timestamps null: false
    end
    add_index :teams, :sport_id
  end
end
