class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.decimal :price, precision: 7, scale: 2
      t.references :item, index: true
      t.timestamps
    end
  end
end
