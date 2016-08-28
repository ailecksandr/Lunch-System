class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.references :order, index: true
      t.references :meal, index: true

      t.timestamps
    end
  end
end
