class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :name
      table.string :password_digest
      table.string :email
      table.decimal :funds, precision: 12, scale: 4
      table.string :role

      table.timestamps null: false
      
      table.index [:name], unique: true
    end
  end
end
