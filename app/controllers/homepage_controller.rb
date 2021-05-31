class HomepageController < ApplicationController
  include JobsHelper
  def index
    @institutions = Institution.last(9)
    jobs = Job.first_12 list_field
    @jobs = if jobs.length < 12
              jobs + Job.limit(12 - jobs.length)
            else
              jobs
            end
  end
end
