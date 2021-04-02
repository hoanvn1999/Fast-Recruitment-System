class InstitutionsController < ApplicationController
  before_action :new_recruitmenr, only: :apply
  before_action :get_institution
  before_action :get_phone, only: [:show, :info]
  before_action :get_users, only: [:users, :update, :fire]
  before_action :get_jobs, only: [:jobs, :apply, :close]

  def show; end

  def info
    respond_to do |format|
      format.js {}
    end
  end

  def users
    respond_to do |format|
      return if current_user.institution_id == @institution.id && @users

      format.js {}
    end

    flash[:warning] = t "institution.deny"
    redirect_to institution_path
  end

  def update
    respond_to do |format|
      user = User.find_by email: params[:email]
      if user &&
         user.institution_id == 1 &&
         user.recruiter!
        user.update(institution_id: current_user.institution_id)
        format.js {}
      else
        format.html do
          flash[:danger] = t "institution.add_hr_fail"
          redirect_to institution_path(id: params[:id])
        end
      end
    end
  end

  def fire
    respond_to do |format|
      user = User.find_by email: params[:email]
      if user.update institution_id: 1
        format.js {}
      else
        flash.now[:danger] = t "institution.remove_hr_fail"
        render :users
      end
    end
  end

  def jobs
    respond_to do |format|
      format.js {}
    end
  end

  def apply
    respond_to do |format|
      if !logged_in?
        format.html do
          apply_not_login
        end
      elsif cv_id.blank?
        # Chuyen sang trang tao CV va thong bao chua tao CV thuoc linh vuc nay
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
    current_user.curriculum_vitaes.where(field_id: job.field_id).ids.first
  end

  def new_recruitmenr
    @recruitment = Recruitment.new job_id: params[:job_id],
                                  curriculum_vitae_id: cv_id
  end

  def get_jobs
    @jobs = Job.job_institution(params[:id])
  end

  def get_institution
    @institution = Institution.find_by id: params[:id]
    return if @institution

    flash[:warning] = t "institution.nil"
    redirect_to root_path
  end

  def get_users
    @users = User.institution_users(params[:id])
  end

  def get_phone
    @phone_numbers = User.institution_users(@institution.id)
                         .includes(:institution).limit(5)
  end

  def apply_not_login
    flash[:warning] = t "account.pls_login"
    redirect_to login_path
  end

  def apply_save
    flash.now[:success] = t "apply.success"
    render :show
  end

  def apply_fail
    flash[:warning] = t "apply.fail"
    redirect_to job_path(id: params[:job_id])
  end
end
