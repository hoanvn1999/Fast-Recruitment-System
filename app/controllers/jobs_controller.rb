class JobsController < ApplicationController
  before_action :new_recruitment, only: :apply
  before_action :get_all_jobs, except: :show

  def index; end

  def show
    @job = Job.find_by id: params[:id]
    @related_jobs = Job.field(@job.field_id).limit(5)
    return if @job

    flash[:danger] = t "job.nil"
    redirect_to root_path
  end

  def apply
    respond_to do |format|
      if !logged_in?
        format.html do
          apply_not_login
        end
      elsif cv_id.blank?
        format.html do
          flash[:warning] = t "create_cv.note"
          redirect_to new_create_cv_path
        end
      elsif @recruitment.save
        format.js {}
        format.html do
          apply_save
        end
      else
        format.html do
          apply_fail
        end
      end
    end
  end

  def close
    recruitment = Recruitment.find_by(curriculum_vitae_id: params[:cv_id],
                                      job_id: params[:id])
    respond_to do |format|
      if recruitment.destroy
        format.js {}
        format.html do
          close_success
        end
      else
        format.html do
          close_fail
        end
      end
    end
  end

  private

  def get_all_jobs
    @jobs = Job.field(params[:field_id])
               .type(params[:type_of_work])
               .arrange_salary(params[:salary])
               .experience(params[:candidate_experience])
               .paginate(page: params[:page],
                         per_page: Settings.per_page.default)
  end

  def cv_id
    job = Job.find_by id: params[:id]
    current_user.curriculum_vitaes.where(field_id: job.field_id).ids.first
  end

  def new_recruitment
    @recruitment = Recruitment.new job_id: params[:id],
                                   curriculum_vitae_id: cv_id
  end

  def apply_not_login
    flash[:warning] = t "account.pls_login"
    redirect_to login_path
  end

  def apply_save
    flash[:success] = t "apply.success"
    redirect_to job_path(id: params[:id])
  end

  def apply_fail
    flash[:warning] = t "apply.fail"
    redirect_to job_path(id: params[:job_id])
  end

  def close_success
    flash[:success] = t "job.close_applied_job"
    redirect_to job_path(id: params[:id])
  end

  def close_fail
    flash[:warning] = t "job.update_fail"
    redirect_to job_path(id: params[:id])
  end
end
