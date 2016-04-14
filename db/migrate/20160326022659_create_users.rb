class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :name
      table.string :password_digest
      table.string :email
      t.decimal :funds
      table.string :role

      table.timestamps null: false
      
      table.index [:name], unique: true
    end
  end
end
