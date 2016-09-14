class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :item_type
      t.timestamps
    end

    add_index :items, :name, unique: true
  end
end
