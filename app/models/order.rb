class Order < ApplicationRecord
  include Scopeable

  has_many :menu_items, dependent: :destroy
  has_many :meals, through: :menu_items
  belongs_to :user
  validates :status, inclusion: { in: %w(open closed) }

  [:first_meal, :main_meal, :drink].each do |name|
    define_method name, -> { self.menu_items.joins(meal: :item).where(items: { item_type: name }).first.meal }
  end

  def status?(status)
    self.status == status.to_s
  end

  def total
    self.menu_items.map(&:meal).sum(&:price)
  end

  def self.summary(date = Time.now)
    Order.up_to_date(date).sum(&:total)
  end
end
