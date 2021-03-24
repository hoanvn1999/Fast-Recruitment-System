class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception
  include SessionsHelper

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def check_login
    return if logged_in?

    flash[:warning] = t "account.pls_login"
    redirect_to login_path
  end

  def check_admin
    return if current_admin?

    flash[:danger] = t "account.not_admin"
    redirect_to root_path
  end

  def check_recruiter
    return if current_recruiter?

    flash[:danger] = t "account.not_recruiter"
    redirect_to root_path
  end

  def check_candidate
    return if current_candidate?

    flash[:danger] = t "account.not_candidate"
    redirect_to root_path
  end
end
