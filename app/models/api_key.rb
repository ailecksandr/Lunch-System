class ApiKey < ApplicationRecord
  scope :actual, -> { where('expired_at >= NOW()') }
  scope :static, -> { where(static: true) }
  scope :active, -> { where('expired_at >= NOW() OR static = true') }
  scope :inactive, -> { where('expired_at < NOW() AND static = false') }

  before_create do
    self.expired_at = Time.now + 15.minutes if self.expired_at.blank?
    generate_access_token! if self.access_token.blank?
  end


  private


  def generate_access_token!
    begin
      self.access_token = Devise.friendly_token(50)
    end while self.class.exists?(access_token: access_token)
  end
end
