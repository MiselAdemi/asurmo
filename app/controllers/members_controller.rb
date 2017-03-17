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

  private

  def set_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end
end
