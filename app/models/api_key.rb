class ApiKey < ApplicationRecord
  scope :actual, -> { where('expired_at >= ? AND static = false', Time.now) }
  scope :static, -> { where(static: true) }
  scope :active, -> { where('expired_at >= ? OR static = true', Time.now) }
  scope :inactive, -> { where('expired_at < ? AND static = false', Time.now) }

  before_create do
    self.expired_at = 15.minutes.from_now if self.expired_at.blank?
    generate_access_token! if self.access_token.blank?
  end


  private


  def generate_access_token!
    begin
      self.access_token = Devise.friendly_token(50)
    end while self.class.exists?(access_token: access_token)
  end
end
