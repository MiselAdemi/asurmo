class Admin::BaseController < ApplicationController
	layout "admin_dashboard"
	
  def authenticate_admin
    authenticate_user!
    unless current_user.admin
      redirect_to user_path(current_user)
    end
  end
end
