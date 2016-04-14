class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.integer :season_id

      t.timestamps null: false
    end
    add_index :portfolios, :user_id
    add_index :portfolios, :season_id
  end
end
