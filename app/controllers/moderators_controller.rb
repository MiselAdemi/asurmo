class ModeratorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_moderators
  before_action :set_moderator

  def index
    authorize @moderator
  end

  def new
    authorize @moderator
  end

  def create
    authorize @moderator
    @new_moderator = @organization.moderators.new(:user_id => params[:organization][:user_id], :role => 1)

    if @new_moderator.save
      respond_with(@new_moderator) do |format|
        format.json { render :json => @new_moderator.as_json }
      end
    else
      render 'new', notice: "Unable to create new moderator"
    end
  end

  def destroy
    moderator = Moderator.find(params[:id])
    moderator.destroy
    redirect_to organization_moderators_path, :notice => "Moderator deleted"
  end

  private
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_moderators
    @moderators = @organization.moderators.where.not(:user_id => current_user.id)
    @moderators_id = @organization.moderators.pluck(:user_id)
    @moderators_info = User.where(:id => @moderators_id).where.not(:id => current_user.id)
  end

  def set_moderator
    moderators = @organization.moderators
    @moderator = moderators.where(:user_id => current_user.id)
  end
end
