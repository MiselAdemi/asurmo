class OrganizationsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!
  before_action :set_organization, :except => [:create, :new, :show]
  before_action :set_moderators, :except => [:create, :new, :show]

  def index
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = current_user.organizations.new
  end

  def create
    @organization = current_user.organizations.build(organization_params)

    # Confirm organization is valid and save or return error
    if @organization.save
      @organization.moderators.create(:user_id => current_user.id, :role => 2)
      # New organization is saved
      respond_with(@organization) do |format|
        format.json { render :json => @organization.as_json }
      end
    else
      render 'new', notice: "Unable to create new organization."
    end
  end

  def edit
    authorize @organization
  end

  def update
    authorize @organization
    respond_to do |format|
      if @organization.update(organization_params)
        @organization.moderators.create(:user_id => organization_params[:user_id], :role => 1)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def organization_params
    params.require(:organization).permit(:name, :user_id)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def set_moderators
    @moderators_id = @organization.moderators.pluck(:user_id)
    @moderators = User.where(:id => @moderators_id)
  end
end
