module Scopeable
  extend ActiveSupport::Concern

  included do
    scope :up_to_date, -> (date = Time.now){ where("date_trunc('day', #{self.to_s.downcase.pluralize}.created_at) = '#{date.beginning_of_day}'").order(:created_at) }
  end
end