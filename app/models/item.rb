class Item < ApplicationRecord
  enum item_type: %w(first_meal main_meal drink)

  has_many :meals
  validates :name, presence: true, length: { in: 4..30 }
  validates :item_type, presence: true
end
