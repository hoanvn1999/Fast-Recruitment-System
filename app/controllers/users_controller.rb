class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update,
                                  :change_password, :update_change_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    check_image_added
    if @user.save
      @user.send_activation_email
      flash[:info] = t "account.check_email"
      redirect_to root_url
    else
      flash[:danger] = t "account.create_fail"
      render :new
    end
  end

  def edit; end

  def change_password; end

  def update
    if current_user.update update_user_params
      flash[:success] = t "account.profile_updated"
      redirect_to root_path
    else
      flash.now[:danger] = t "account.update_fail"
      render :edit
    end
  end

  def update_change_password
    if update_password_params[:password].blank?
      flash.now[:danger] = t "reset_passwd.input_passwd"
      render :change_password
    elsif valid_passwd && current_user.update(update_password_params)
      flash[:success] = t "account.passwd_updated"
      redirect_to root_path
    else
      flash.now[:danger] = t "account.change_pwd_fail"
      render :change_password
    end
  end

  private

  def get_user
    @user = current_user
    return if @user

    flash[:warning] = t "account.account_nil"
    redirect_to new_users_path
  end

  def user_params
    params.require(:user)
          .permit :full_name, :email, :password, :password_confirmation,
                  :role, :phone_number, :address, :date_of_birth, :avatar
  end

  def update_user_params
    params.require(:user)
          .permit :full_name, :role, :phone_number, :address,
                  :date_of_birth, :avatar
  end

  def update_password_params
    params.require(:user)
          .permit :password, :password_confirmation
  end

  def valid_passwd
    current_user&.authenticate params[:user][:old_password]
  end

  def check_image_added
    @user.avatar.attach(io: File.open("app/assets/images/avatars/user-avt.png"),
                         filename: "myself.jpg", content_type: "image/png")
    return unless params[:user][:avatar].nil?
  end
end
