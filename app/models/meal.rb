class Meal < ApplicationRecord
  include Scopeable, WorkingDayseable

  enum meal_type: %w(first_meal main_meal drink)

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1.0, less_than_or_equal_to: 500.0 }
  validates :name, presence: true, length: { in: 4..30 }
  validates :meal_type, presence: true

  scope :sorted, -> { joins(:item).order(:price, :name) }

  def self.menu_completed?(date = Time.now)
    Meal.up_to_date(date).pluck(:meal_type).uniq.size == Meal.meal_types.size
  end

  def up_to_date?(date = Time.now)
    self.created_at.beginning_of_day == date.beginning_of_day
  end
end
