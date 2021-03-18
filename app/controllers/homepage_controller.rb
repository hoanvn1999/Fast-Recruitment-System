class HomepageController < ApplicationController
  def index
    @institutions = Institution.first_9
    @jobs = Job.first_12
  end
end
