class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.text :description
      t.string :picture
      t.string :username
      t.string :password
      t.string :confirmation

      t.timestamps null: false
    end
  end
end
