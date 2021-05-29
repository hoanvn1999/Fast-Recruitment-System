class Candidate::RecruitmentsController < CandidateController
  before_action :new_recruitment, only: :create

  def create
    respond_to do |format|
      if !logged_in?
        format.html do
          flash[:warning] = t "account.pls_login"
          redirect_to login_path
        end
      elsif cv_id.blank?
        # Chuyen sang trang tao CV va thong bao chua tao CV thuoc linh vuc nay
      elsif @recruitment.save
        format.js {}
      else
        format.html do
          flash[:warning] = t "apply.fail"
          redirect_to job_path(id: params[:job_id])
        end
      end
    end
  end

  def destroy
    recruitment = Recruitment.find_by(curriculum_vitae_id: params[:cv_id],
                                      job_id: params[:job_id])
    respond_to do |format|
      if recruitment.destroy
        format.js {}
      else
        format.html do
          flash[:warning] = t "job.update_fail"
          redirect_to candidate_curriculum_vitae_applied_path
        end
      end
    end
  end

  private

  def cv_id
    job = Job.find_by id: params[:job_id]
    current_user.curriculum_vitaes.where(field_id: job.field_id).ids
  end

  def new_recruitment
    @recruitment = Recruitment.new job_id: params[:job_id],
                                  curriculum_vitae_id: cv_id
  end
end
