class Meal < ApplicationRecord
  include Scopeable

  belongs_to :item
  has_many :menu_items, dependent: :destroy
  has_many :orders, through: :menu_items
  validates :price, presence: true
  validates :item_id, presence: true
  scope :sorted, -> { joins(:item).order('meals.price, items.name')}
  [:first_meal, :main_meal, :drink].each do |type|
    scope "#{type}s", -> { joins(:item).where(items: { item_type: type }).sorted }
  end

  def self.menu_completed?(date)
    Meal.up_to_date(date).map{ |meal| meal.item.item_type }.uniq.size == 3
  end

  def today?
    self.created_at.today?
  end
end
