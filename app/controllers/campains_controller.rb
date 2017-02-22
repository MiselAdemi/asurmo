class CampainsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_campain, :only => [:show]
  respond_to :html, :json

  def index
  end

  def show
  end

  def new
    @campain = @organization.campains.new
  end

  def create
    @campain = @organization.campains.build(campain_params)

    if @campain.save
      respond_with(@campain) do |format|
        format.html { redirect_to organization_campain_path(@organization, @campain) }
        format.json { render :json => @campain.as_json }
      end
    else
      render 'new', :notice => "Unable to create new organization"
    end
  end

  private

  def set_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def campain_params
    params.require(:campain).permit(:name)
  end

  def set_campain
    @campain = Campain.friendly.find(params[:id])
  end
end
