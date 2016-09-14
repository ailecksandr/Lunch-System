class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :role, :integer, default: 0
    add_column :users, :nickname, :string, null: false
    add_index :users, :nickname, unique: true
    add_attachment :users, :avatar
  end

  def down
    remove_column :users, :role
    remove_column :users, :nickname
    remove_index :users, :nickname
    remove_attachment :users, :avatar
  end
end
