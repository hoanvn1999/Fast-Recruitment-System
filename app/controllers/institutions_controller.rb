class InstitutionsController < ApplicationController
  before_action :get_institution
  before_action :get_phone, only: [:show, :info]
  before_action :get_users, only: [:users, :update, :fire]

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
      @jobs = Job.job_institution(params[:id])
      format.js {}
    end
  end

  private

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
end
