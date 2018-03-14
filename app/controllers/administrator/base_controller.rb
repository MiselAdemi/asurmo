class Administrator::BaseController < ApplicationController
	layout "administrator"

  before_action :set_organization

  def authenticate_admin
    authenticate_user!
  end

  private

  def set_organization
    if params[:organization_id].present?
      @organization = Organization.friendly.find(params[:organization_id])
    else
      @organization = Organization.friendly.find(params[:id])
    end
  end
end
