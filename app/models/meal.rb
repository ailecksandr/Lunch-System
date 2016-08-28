class Meal < ApplicationRecord
  include Scopeable

  belongs_to :item
  has_many :menu_items, dependent: :destroy
  has_many :orders, through: :menu_items
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1.0, less_than_or_equal_to: 100.0 }
  validates :item_id, presence: true
  scope :sorted, -> { joins(:item).order('meals.price, items.name')}
  Item::TYPES.each do |type|
    scope "#{type}s", -> { joins(:item).where(items: { item_type: type }).sorted }
  end

  def self.menu_completed?(date = Time.now)
    Meal.up_to_date(date).map{ |meal| meal.item.item_type }.uniq.size == 3
  end

  def up_to_date?(date = Time.now)
    self.created_at.beginning_of_day == date.beginning_of_day
  end
end
