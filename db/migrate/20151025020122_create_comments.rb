class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :photo
      t.text :comment

      t.timestamps null: false
    end
  end
end
