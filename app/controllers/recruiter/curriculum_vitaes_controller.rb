class Recruiter::CurriculumVitaesController < RecruiterController
  before_action :get_cv, only: [:show, :send_email]

  def show; end

  def send_email
    get_email_info
    if @recruitment
      @recruitment.update interview_time: params[:interview_time]
      JobMailer.interview(@candidate, @recruiter, @recruitment)
               .deliver_later
      flash[:success] = t "email.sent.success"
    else
      flash[:danger] = t "email.sent.fail"
    end
    redirect_to cvs_recruiter_job_path(id: params[:job_id])
  end

  private

  def get_cv
    @cv = CurriculumVitae.find_by id: params[:cv_id]
  end

  def get_email_info
    @candidate = @cv.user
    @recruiter = current_user
    @recruitment = Recruitment.find_by curriculum_vitae_id: params[:cv_id],
                                       job_id: params[:job_id]
  end
end
