class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update,
                                  :change_password, :update_change_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    check_image_added
    generate_password_for_google_registration

    if @user.save
      if is_register_with_google?
        log_in @user
        session[:new_user] = nil
      else
        @user.send_activation_email
        flash[:info] = t "account.check_email"
      end
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

  def google_registration
    @user = User.new session[:new_user]
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

  def is_register_with_google?
    request.referer.include?("google_registration")
  end

  def generate_password_for_google_registration
    return unless is_register_with_google?

    new_password = SecureRandom.base64(12)
    @user.password = new_password
    @user.password_confirmation = new_password
    @user.activated = true
  end
end
