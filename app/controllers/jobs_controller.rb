class JobsController < ApplicationController
  def index
    @jobs = Job.all.paginate(page: params[:page],
                             per_page: Settings.per_page.default)
  end

  def show
    @job = Job.find_by id: params[:id]
    @related_jobs = Job.related_jobs(@job.field_id).limit(5)
    return if @job

    flash[:danger] = t "job.nil"
    redirect_to root_path
  end
end
