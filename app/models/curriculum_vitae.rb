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
  accepts_nested_attributes_for :experiences
  accepts_nested_attributes_for :extra_experiences
  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :languages
  accepts_nested_attributes_for :hobbies
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :references
  has_many :recruitments
  has_many :jobs, through: :recruitments
  has_one_attached :cv_image

  scope :find_name, ->(name){where("full_name LIKE ?", "%#{name}%")}

  list = lambda do |field_id|
    if field_id.blank?
      all
    else
      where("field_id = ?", field_id)
    end
  end
  scope :find_field, list

  def education_time
    educations.map{|e| ((e.end_date - e.start_date) / 31_536_000).round(2)}
              .sum || 0
  end

  def experience_time
    experiences.map{|e| ((e.end_date - e.start_date) / 31_536_000).round(2)}
               .sum || 0
  end
end
