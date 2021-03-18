class Field < ApplicationRecord
  has_many :jobs
  has_many :curriculum_vitaes
end
