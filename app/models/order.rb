class Order < ApplicationRecord
  include Scopeable
  enum status: %w(open closed)

  has_many :menu_items, dependent: :destroy
  has_many :meals, through: :menu_items
  belongs_to :user

  accepts_nested_attributes_for :menu_items, allow_destroy: true
  validate :without_all_meals?, on: :create, if: proc { |order| order.menu_items.size != 3 }

  Item.item_types.keys.each do |type|
    define_method type, -> { self.menu_items.joins(meal: :item).where(items: { item_type: Item.item_types[type] }).first.try(:meal) }
  end

  def total
    self.menu_items.map(&:meal).sum(&:price)
  end

  def self.summary(date = Time.now)
    Order.up_to_date(date).sum(&:total)
  end


  private


  def without_all_meals?
    errors.add(:base, 'Choose all meals')
  end
end

