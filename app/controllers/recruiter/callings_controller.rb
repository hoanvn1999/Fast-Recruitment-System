class Recruiter::CallingsController < ApplicationController
  def show
    @cv = CurriculumVitae.find_by id: params[:id]
  end
end
