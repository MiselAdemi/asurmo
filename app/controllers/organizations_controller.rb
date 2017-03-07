class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, :except => [:create, :new, :index]
  before_action :set_moderators, :except => [:create, :new, :show, :index]
  before_action :set_user
  before_action :set_campains, :only => [:show]
  respond_to :html, :json

  def index
    #owned organizations
    @organizations_id = Member.where(:user => current_user).where(:role => 2).pluck(:organization_id)
    @owner_organizations = current_user.organizations.where(:id => @organizations_id)

    #moderated organizations
    @organizations_id = Member.where(:user => current_user).where(:role => 1).pluck(:organization_id)
    @moderate_organizations = current_user.organizations.where(:id => @organizations_id)

    # organizations where user has member permission
    @organizations_id = Member.where(:user => current_user).where(:role => 0).pluck(:organization_id)
    @member_organizations = current_user.organizations.where(:id => @organizations_id)

    @organization = current_user.organizations.new
  end

  def show
    @campain = @organization.campains.new
  end

  def new
    @organization = current_user.organizations.new
  end

  def create
    @organization = current_user.organizations.build(organization_params)

    # Confirm organization is valid and save or return error
    if @organization.save
      @organization.members.create(:user_id => current_user.id, :role => 2)
      track_activity(@organization)
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
        @organization.moderators.create(:user_id => params[:organization][:user_id], :role => 1)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def join_member
    @organization.members.create(:user_id => params[:user_id], :role => 0)
    redirect_to organization_path(@organization)
  end

  def remove_member
    @organization.members.where(:user_id => params[:user_id]).first.destroy
    #Member.find(:user_id => params[:user_id]).destroy
    redirect_to organization_path(@organization)
  end

  def destroy
    untrack_activity(@organization)
    @organization.destroy
    redirect_to organizations_path(current_user)
  end

  private
  def organization_params
    params.require(:organization).permit(:name, :description, :avatar)
  end

  def set_organization
    if params[:organization_id]
      @organization = Organization.friendly.find(params[:organization_id])
    else
      @organization = Organization.friendly.find(params[:id])
    end
  end

  def set_moderators
    @moderators_id = @organization.members.where(:role => 2).pluck(:user_id)
    @moderators = User.where(:id => @moderators_id)
  end

  def set_user
    @user = current_user
  end

  def set_campains
    @campains = @organization.campains
  end
end
