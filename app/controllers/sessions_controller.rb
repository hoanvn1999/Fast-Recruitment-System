class SessionsController < ApplicationController
  before_action :get_user, only: :create

  def new
    redirect_to root_path if logged_in?
  end

  def create
    if @user&.authenticate params[:session][:password]
      if @user.activated
        log_in @user
        remember_me
        redirect_to root_path
      else
        flash.now[:warning] = t "login.check_activation_link"
        render :new
      end
    else
      flash.now[:danger] = t "login.invalid_user"
      render :new
    end
  end

  def destroy
    log_out

    redirect_to root_path
  end

  private

  def get_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash.now[:warning] = t "account.account_nil"
    render :new
  end

  def remember_me
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
  end
end
