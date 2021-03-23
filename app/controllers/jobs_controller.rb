class JobsController < ApplicationController
  def index
    @jobs = Job.field(params[:field_id])
               .type(params[:type_of_work])
               .arrange_salary(params[:salary])
               .experience(params[:candidate_experience])
               .paginate(page: params[:page],
                         per_page: Settings.per_page.default)
  end

  def show
    @job = Job.find_by id: params[:id]
    @related_jobs = Job.field(@job.field_id).limit(5)
    return if @job

    flash[:danger] = t "job.nil"
    redirect_to root_path
  end
end
