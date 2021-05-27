class Field < ApplicationRecord
  has_many :jobs
  has_many :curriculum_vitaes

  field = lambda do |field_name|
    if name.present?
      where("field_name LIKE ?", "%#{field_name}%")
    else
      all
    end
  end
  scope :find_field, field
end
