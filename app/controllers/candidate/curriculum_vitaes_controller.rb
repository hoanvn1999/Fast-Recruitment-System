class Candidate::CurriculumVitaesController < CandidateController
  before_action :get_cv, only: [:edit, :update]
  before_action :get_jobs, only: [:applied, :close]

  def index
    @cvs = CurriculumVitae.where(user_id: current_user.id)
                          .find_field(params[:field_id])
    return if @cvs

    flash[:danger] = t "cv.nil.cv"
    redirect_to root_path
  end

  def new
    @cv = CurriculumVitae.new
  end

  def create; end

  def edit; end

  def update; end

  def applied; end

  def close
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

  def get_cv
    @cv = CurriculumVitae.find_by id: params[:id]
  end

  def get_jobs
    @jobs = Job.joins(:curriculum_vitaes)
               .where("curriculum_vitaes.user_id = ?", current_user.id)
               .title(params[:title])
    return if @jobs

    flash[:danger] = t "cv.nil.job"
    redirect_to root_path
  end
end
