class RecruiterController < ApplicationController
  before_action :check_login, :check_recruiter
end
