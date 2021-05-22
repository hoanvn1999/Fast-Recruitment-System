class HomepageController < ApplicationController
  def index
    @institutions = Institution.last(9)
    @jobs = Job.first_12
  end
end
