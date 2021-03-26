class Recruiter::CurriculumVitaesController < RecruiterController
  before_action :get_cv, only: [:show, :send_email]

  def show; end

  def send_email; end

  private

  def get_cv
    @cv = CurriculumVitae.find_by id: params[:id]
  end
end
