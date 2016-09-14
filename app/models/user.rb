class User < ApplicationRecord
  enum role: %w(user admin system)

  has_many :orders, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_attached_file :avatar, default_url: 'missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :nickname, presence: true, length: { in: 3..25 }, uniqueness: true

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :worker, -> { where.not(role: 'system') }

  def after_confirmation
    self.update(role: 'admin') if User.confirmed.size == 1
  end

  def self.find_for_google_oauth2(response)
    user = User.find_by_uid(response.extra.raw_info.sub)
    return user if user.present?

    user = User.new(
      nickname: response.info.name,
      email: "#{response.info.email.split('@')[0]}@lunch.com",
      password: Devise.friendly_token[0,20],
      provider: :google,
      uid: response.extra.raw_info.sub,
      avatar: open(response.info.image),
      role: !User.confirmed.empty? ? 'user' : 'admin'
    )
    user.skip_confirmation!
    user.save
    user
  end
end
