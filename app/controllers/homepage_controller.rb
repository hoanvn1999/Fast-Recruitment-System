class HomepageController < ApplicationController
  def index
    @institutions = Institution.last(9)
    jobs = Job.first_12 list_field
    @jobs = if jobs.length < 12
              jobs + Job.limit(12 - jobs.length)
            else
              jobs
            end
  end

  def list_field
    list = []
    if logged_in?
      current_user.curriculum_vitaes.each do |cv|
        list << cv.field_id
      end
    end
    list.map(&:inspect).join(", ")
  end
end
