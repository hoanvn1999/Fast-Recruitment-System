class Job < ApplicationRecord
  belongs_to :user
  belongs_to :field
  has_many :recruitments
  has_many :curriculum_vitaes, through: :recruitments
  has_one_attached :post_image

  validates :number_of_staffs, presence: true,
    length: {maximum: Settings.job.max_staffs}
  validates :min_salary, presence: true,
    length: {maximum: Settings.job.min_salary}
  validates :max_salary, presence: true,
    length: {maximum: Settings.job.min_salary}
  # min<max salary
  validate :max_salary_must_be_greater
  validate :due_date_cannot_be_in_the_past
  # due_date < now
  validates :title, presence: true
  validates :content, presence: true

  def max_salary_must_be_greater
    errors.add(:max_salary, "must be greater") if min_salary >= max_salary
  end

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if
      due_date.present? && due_date < Time.zone.today
  end

  enum type_of_work: {full_time: 0, part_time: 1, remote: 2}
  enum position: {director: 0, manager: 1, leader: 2,
                  staff: 3, fresher: 4, intern: 5}
  enum status: {locked: 0, actived: 1}

  scope :first_12, ->{order(created_at: :desc).limit 12}
  scope :related_jobs, ->(field_id){where("field_id = ?", field_id)}
end
