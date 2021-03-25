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
  enum status: {closed: 0, actived: 1}

  scope :first_12, ->{order(created_at: :desc).limit 12}

  user = lambda do |user_id|
    if user_id.present?
      where("user_id = ?", user_id)
    else
      all
    end
  end
  scope :user_id, user

  field = lambda do |field_id|
    if field_id.present?
      where("field_id = ?", field_id)
    else
      all
    end
  end
  scope :field, field

  type = lambda do |type_of_work|
    if type_of_work.present?
      where("type_of_work = ?", type_of_work)
    else
      all
    end
  end
  scope :type, type

  arr = lambda do |arrange_salary|
    if arrange_salary == "asc"
      order(min_salary: :asc)
    else
      order(min_salary: :desc)
    end
  end
  scope :arrange_salary, arr

  experience = lambda do |exp|
    if exp.present?
      where("candidate_experience <= ?", exp)
    else
      all
    end
  end
  scope :experience, experience

  j_i = lambda do |institution_id|
    find_by_sql("
      SELECT * FROM jobs
      INNER JOIN users ON jobs.user_id = users.id
      INNER JOIN institutions ON users.id = institutions.id
      WHERE institutions.id = #{institution_id}")
  end
  scope :job_institution, j_i
end
