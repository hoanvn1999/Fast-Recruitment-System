class Admin::JobsController < AdminController
  before_action :get_job, only: [:update, :open]
  before_action :get_all_job

  def index; end

  def update
    respond_to do |format|
      if @job.closed!
        format.html do
          flash[:success] = t "job.update_success"
          redirect_to admin_jobs_path
        end
      else
        format.html do
          flash[:warning] = t "job.update_fail"
          redirect_to admin_jobs_path
        end
      end
      format.js {}
    end
  end

  def open
    respond_to do |format|
      if @job.actived!
        format.html do
          flash[:success] = t "job.update_success"
          redirect_to admin_jobs_path
        end
      else
        format.html do
          flash[:warning] = t "job.update_fail"
          redirect_to admin_jobs_path
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

  def get_all_job
    @jobs = Job.title(params[:title])
  end
end
