class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.references :first_meal, index: true, references: :meals
      t.references :main_meal, index: true, references: :meals
      t.references :drink, index: true, references: :meals

      t.timestamps
    end
  end
end
