class Admin::UsersController < AdminController
  before_action :get_user, only: [:block, :active]
  before_action :get_all_user

  def index; end

  def block
    respond_to do |format|
      if @user.blocked!
        format.html do
          flash[:success] = t "account.blocked"
          redirect_to admin_users_path
        end
        format.js {}
      else
        flash.now[:warning] = t "account.activated"
        render :edit
      end
    end
  end

  def active
    respond_to do |format|
      if @user.actived!
        format.html do
          flash[:success] = t "account.activated"
          redirect_to admin_users_path
        end
        format.js {}
      else
        flash.now[:warning] = t "account.activated_fail"
        render :edit
      end
    end
  end

  private

  def get_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user.nil"
    redirect_to new_recruiter_user_path
  end

  def get_all_user
    @users = User.role(params[:role]).email(params[:email])
                 .paginate(page: params[:page],
                           per_page: Settings.per_page.default)
  end
end
