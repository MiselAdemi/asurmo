class Admin::BaseController < ApplicationController
  def authenticate_admin
    authenticate_user!
    unless current_user.admin
      redirect_to user_path(current_user)
    end
  end
end
