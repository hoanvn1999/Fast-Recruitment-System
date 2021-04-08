class Candidate::CallingsController < ApplicationController
  def show
    @job = Job.find_by id: params[:id]
  end
end
