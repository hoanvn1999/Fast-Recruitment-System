class User < ApplicationRecord
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
    length: {minimum: Settings.user.password.min_length}
  validates :phone_number, presence: true,
    length: {minimum: Settings.user.phone.min_length,
             maximum: Settings.user.phone.max_length}
  validates :date_of_birth, presence: true
  validates :address, presence: true

  enum role: {recruiter: 0, candidate: 1, admin: 2}

  has_secure_password
end
