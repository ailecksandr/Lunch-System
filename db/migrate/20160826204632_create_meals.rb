class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.string :name, null: false
      t.integer :meal_type
      t.decimal :price, precision: 7, scale: 2

      t.timestamps
    end
  end
end
