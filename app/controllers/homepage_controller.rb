class HomepageController < ApplicationController
  def index
    @institutions = get_list_institutions
    @jobs = get_list_jobs
  end

  private

  def get_list_institutions
    institutions = Institution.distinct
                              .joins(:jobs).group("institutions.id")
                              .order("COUNT(institutions.id) DESC").limit(9)
    return institutions unless institutions.length < 9
    institutions + Institution.where.not(id: institutions.ids)
                              .limit(9 - institutions.length)
                              .order(created_at: :desc)
  end

  def get_list_jobs
    fields = logged_in? ? current_user.curriculum_vitaes.map(&:field) : []
    jobs = Job.where(field: fields)
              .where(created_at: 3.months.ago..Time.zone.now)
              .limit(12).order(created_at: :desc)
    return jobs unless jobs.length < 12
    jobs + Job.where.not(id: jobs.ids)
              .limit(12 - jobs.length).order(created_at: :desc)
  end
end
