class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :type
      t.timestamps
    end

    add_index :name, unique: true
  end
end
