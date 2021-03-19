class SessionsController < ApplicationController
  before_action :get_user, only: :create

  def new
    redirect_to root_path if logged_in?
  end

  def create
    if @user&.authenticate params[:session][:password]
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_to root_path
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
  end
end
