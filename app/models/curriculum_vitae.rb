class CurriculumVitae < ApplicationRecord
  belongs_to :user
  belongs_to :field
  has_many :educations
  has_many :experiences
  has_many :extra_experiences
  has_many :skills
  has_many :languages
  has_many :hobbies
  has_many :references
  has_many :recruitments
  has_many :jobs, through: :recruitments
  has_one_attached :cv_image

  scope :find_name, ->(name){where("full_name LIKE ?", "%#{name}%")}
end
