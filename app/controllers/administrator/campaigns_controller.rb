class Administrator::CampaignsController < Administrator::BaseController
  before_action :authenticate_admin
  before_action :set_campaign, only: [ :show, :edit, :update, :participant_users ]

  def index
  end

  def show
    @calendar_items = @campaign.events + @campaign.tasks
    @all_comments = (CampainsHelper::all_events_comments(@campaign) + CampainsHelper::all_tasks_comments(@campaign)).flatten.sort_by{|c| c[:created_at]}.reverse
  end

  def new
    @campaign = @organization.campains.new
    @campaign.participants.build
  end

  def create
    @campaign = @organization.campains.build(campaign_params)

    respond_to do |format|
      if @campaign.save
        CampainsHelper.update_team(@campaign, params[:team_id])
        CampainsHelper.update_viewable_users(@campaign, params[:users_id])

        format.html { redirect_back(fallback_location: root_path, notice: 'Campaign was successfully created.' ) }
        format.json { render :json => @campaign.as_json }
      else
        render 'new', :notice => "Unable to create new campaign"
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        CampainsHelper.update_team(@campaign, params[:team_id])
        # CampainsHelper.update_viewable_users(@campaign, params[:users_id])

        format.html { redirect_back(fallback_location: root_path, notice: 'Campaign was successfully updated.' ) }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def participant_users
    respond_to do |format|
      format.json { render :json => @campaign.participant_users }
    end
  end

  private

  def campaign_params
    params.require(:campain).permit(:name, :avatar, :users_id, events_attributes: [ :id, :name], participant_user_ids: [])
  end

  def set_campaign
    @campaign = @organization.campains.friendly.find(params[:id])
  end
end
