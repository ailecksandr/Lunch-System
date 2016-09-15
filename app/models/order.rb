class Order < ApplicationRecord
  include Scopeable

  enum status: %w(open closed)

  belongs_to :user
  belongs_to :first_meal, class_name: Meal
  belongs_to :main_meal, class_name: Meal
  belongs_to :drink, class_name: Meal

  validates :first_meal_id, :main_meal_id, :drink_id, presence: true

  scope :eager, -> { includes(:user, :first_meal, :main_meal, :drink) }

  def meals
    Meal.meal_types.keys.map{|type| send(type) }
  end

  def total
    self.meals.sum(&:price)
  end

  def self.summary(date = Time.now)
    ActiveRecord::Base.connection.execute("
      SELECT SUM(price) FROM meals
      INNER JOIN orders ON meals.id
      IN (orders.first_meal_id, orders.main_meal_id, orders.drink_id)
      WHERE orders.created_at >= '#{date.beginning_of_day}' AND
        orders.created_at <= '#{date.end_of_day}'
    ")[0]['sum'].to_f
  end
end

