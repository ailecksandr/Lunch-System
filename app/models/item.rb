class Item < ApplicationRecord
  TYPES = %w(first_meal main_meal drink)
  has_many :meals
  validates :name, presence: true, length: { in: 4..30 }
  validates :item_type, presence: true, inclusion: { in: TYPES }

  TYPES.each do |type|
    scope "#{type}s", -> { where(item_type: type) }
  end
end
