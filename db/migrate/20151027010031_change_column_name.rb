class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :password, :encrypted_password
  	rename_column :users, :confirmation, :salt
  end
end
