class SessionsController < ApplicationController
  before_action :get_user, only: :create

  def new
    redirect_to root_path if logged_in?
  end

  def create
    if @user&.authenticate params[:session][:password]
      login_user
    else
      flash.now[:danger] = t "login.invalid_user"
      render :new
    end
  end

  def destroy
    log_out

    redirect_to root_path
  end

  def google_login
    res = request.env["omniauth.auth"]
    @user = User.find_by email: res["info"]["email"]
    return login_user if @user

    session[:new_user] = {
      email: res["info"]["email"],
      full_name: "#{res['info']['last_name']} #{res['info']['first_name']}"
    }

    redirect_to google_registration_users_path
  end

  private

  def login_user
    if @user.activated
      log_in @user
      remember_me
      redirect_to root_path
    else
      flash.now[:warning] = t "login.check_activation_link"
      render :new
    end
  end

  def get_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash.now[:warning] = t "account.account_nil"
    render :new
  end

  def remember_me
    status = params.dig(:session, :remember_me) == "1" ||
             params[:acction] == "google_login"
    status ? remember(@user) : forget(@user)
  end
end
