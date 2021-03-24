class InstitutionsController < ApplicationController
  before_action :get_institutions

  def show
    @phone_numbers = User.institution_users(@institution.id)
                         .includes(:institution).limit(5)
  end

  def users
    @users = User.institution_users(params[:id])
    return if current_user.institution_id == @institution.id && @users

    flash[:warning] = t "institution.deny"
    redirect_to institution_path
  end

  def jobs
    @jobs = Job.job_institution(params[:id])
  end

  private

  def get_institutions
    @institution = Institution.find_by id: params[:id]
    return if @institution

    flash[:warning] = t "institution.nil"
    redirect_to root_path
  end
end
