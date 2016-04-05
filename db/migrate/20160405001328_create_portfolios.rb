class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.integer :league_id
      t.decimal :funds

      t.timestamps null: false
    end
    add_index :portfolios, :user_id
    add_index :portfolios, :league_id
  end
end
