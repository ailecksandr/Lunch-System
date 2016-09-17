class Order < ApplicationRecord
  include Scopeable

  enum status: %w(open closed)

  belongs_to :user
  belongs_to :first_meal, class_name: 'Meal'
  belongs_to :main_meal, class_name: 'Meal'
  belongs_to :drink, class_name: 'Meal'

  validates :first_meal_id, :main_meal_id, :drink_id, presence: true

  def meals
    Meal.meal_types.keys.map{|type| send(type) }
  end

  def total
    self.meals.sum(&:price)
  end

  def self.summary(date = Time.now)
    Order.up_to_date(date).sum(&:total)
  end
end

