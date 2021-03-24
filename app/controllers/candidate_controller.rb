class CandidateController < ApplicationController
  before_action :check_login, :check_candidate
end
