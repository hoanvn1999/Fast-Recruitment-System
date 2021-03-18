class Institution < ApplicationRecord
  has_many :users
  has_one_attached :logo

  validates :institution_name, presence: true
  validates :address, presence: true

  scope :first_9, ->{order(created_at: :desc).limit 9}
end
