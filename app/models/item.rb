class Item < ApplicationRecord
  validates :name, presence: true, length: { in: 4..30 }
end
