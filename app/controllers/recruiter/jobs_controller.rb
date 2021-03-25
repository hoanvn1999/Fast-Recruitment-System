class Recruiter::JobsController < RecruiterController
  before_action :get_job, only: [:edit, :update, :close]
  before_action :get_all_jobs, only: [:index, :close]

  def index; end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params
    @job.user_id = current_user.id
    if params[:job][:post_image] && @job.save
      flash[:success] = t "job.create_success"
      redirect_to recruiter_jobs_path
    else
      flash.now[:warning] = t "job.create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @job.update job_params
      flash[:success] = t "job.update_success"
      redirect_to job_path(id: @job.id)
    else
      flash.now[:warning] = t "job.update_fail"
      render :edit
    end
  end

  def close
    respond_to do |format|
      if @job.closed!
        format.html do
          flash[:success] = t "job.update_success"
          redirect_to recruiter_jobs_path
        end
      else
        format.html do
          flash[:warning] = t "job.update_fail"
          redirect_to recruiter_jobs_path
        end
      end
      format.js {}
    end
  end

  private

  def get_job
    @job = Job.find_by id: params[:id]
    return if @job

    flash[:danger] = t "job.nil"
    redirect_to new_recruiter_job_path
  end

  def get_all_jobs
    @jobs = Job.user_id current_user.id
  end

  def job_params
    params.require(:job)
          .permit :title, :field_id, :post_image, :number_of_staffs,
                  :type_of_work, :position, :min_salary, :max_salary,
                  :candidate_experience, :due_date, :content
  end
end
