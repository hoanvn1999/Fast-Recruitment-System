class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  belongs_to :institution
  has_many :jobs
  has_many :curriculum_vitaes
  has_one_attached :avatar

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  include BCrypt

  validates :full_name, presence: true
  validates :email, presence: true,
    length: {maximum: Settings.user.email.max_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.min_length},
    allow_nil: true
  validates :phone_number, presence: true,
    length: {minimum: Settings.user.phone.min_length,
             maximum: Settings.user.phone.max_length}
  validates :date_of_birth, presence: true
  validates :address, presence: true

  enum role: {recruiter: 0, candidate: 1, admin: 2}

  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             Engine::MIN_COST
           else
             Engine.cost
           end
    Password.create string, cost: cost
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    Password.new(digest).is_password? token
  end

  def forget
    update remember_digest: nil
  end

  def active
    update activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token),
           reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
