class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user&.blocked? &&
       user&.authenticated?(:activation, params[:id])
      user.actived!
      user.update actived_at: Time.zone.now
      log_in user
      flash[:success] = t "account.activated"
    else
      flash[:danger] = t "account.invalid_active_link"
    end
    redirect_to root_path
  end
end
