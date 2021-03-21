class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "reset_passwd.email_sent"
      redirect_to root_path
    else
      flash.now[:danger] = t "reset_passwd.email_nil"
      render :new
    end
  end

  def update
    if user_params[:password].blank?
      flash.now[:danger] = t "reset_passwd.input_passwd"
      render :edit
    elsif @user.update user_params
      flash[:success] = t "account.passwd_updated"
      redirect_to login_path
    else
      flash.now[:danger] = t "account.change_pwd_fail"
      render :new
    end
  end

  private

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    return if @user&.activated && @user&.authenticated?(:reset, params[:id])

    flash[:danger] = t "account.invalid_reset_passwd_link"
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "reset_passwd.expired"
    redirect_to new_password_reset_url
  end
end
