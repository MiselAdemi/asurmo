class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_members
  before_action :set_member
  before_action :set_potential_members, :only => [ :new, :create ]

  def index
    authorize @member
  end

  def new
    authorize @member
  end

  def create
    authorize @member
    @new_member = @organization.members.new(:user_id => params[:organization][:user_id], :role => 1)

    if @new_member.save
      respond_with(@new_member) do |format|
        format.json { render :json => @new_member.as_json }
      end
    else
      render 'new', notice: "Unable to create new moderator"
    end
  end

  def destroy
    member = Member.find(params[:id])
    member.destroy
    redirect_to organization_memberss_path, :notice => "Member deleted"
  end

  private
  def set_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def set_members
    @members = @organization.members.where.not(:user_id => current_user.id)
    @members_id = @organization.members.pluck(:user_id)
    @members_info = User.where(:id => @members_id).where.not(:id => current_user.id)
  end

  def set_member
    members = @organization.members
    @member = members.where(:user_id => current_user.id)
  end

  def set_potential_members
    current_members = @organization.members
    @potential_members = User.where.not(:id => current_members)
  end
end
