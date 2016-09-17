module Scopeable
  extend ActiveSupport::Concern

  included do
    scope :up_to_date, -> (date = Time.now){ where("created_at >= '#{date.beginning_of_day}' AND created_at <= '#{date.end_of_day}'") }
  end
end