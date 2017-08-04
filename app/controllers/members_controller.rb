class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization

  def create
    @organization.join(current_user)
    redirect_to :back
  end

  def destroy
    @organization.exit(current_user)
    redirect_to :back
  end

  def create_admin
    @organization.add_admin(get_user_by_email)

    redirect_to :back
  end

  def remove_admin
    @organization.remove_admin(get_user_by_id)

    redirect_to :back
  end

  def create_moderator
    @organization.add_moderator(get_user_by_email)

    redirect_to :back
  end

  def remove_moderator
    @organization.remove_moderator(get_user_by_id)

    redirect_to :back
  end

  private

  def set_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def admin_params
    params.permit(:user_email)
  end

  def get_user_by_email
    User.find_by_email(admin_params[:user_email])
  end

  def get_user_by_id
    @organization.members.where(:user_id => params[:user]).first
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
