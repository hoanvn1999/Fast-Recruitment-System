class AdminController < ApplicationController
  before_action :check_login, :check_admin
end
