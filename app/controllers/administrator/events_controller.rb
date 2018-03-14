class Administrator::EventsController < Administrator::BaseController
  before_action :authenticate_admin
  before_action :set_campaign, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_event, only: [ :edit, :update, :destroy ]

  def index

  end

  def new
    @event = @campaign.events.new
  end

  def create
    @event = @campaign.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_back(fallback_location: root_path, notice: 'Event was successfully created.' ) }
        format.json { render :json => @event.as_json }
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
        format.html { redirect_back(fallback_location: root_path, notice: 'Campaign was successfully updated.' ) }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    redirect_to edit_administrator_organization_campaign_path(@organization, @campaign)
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :avatar, :description, :start_date, :end_date)
  end

  def set_campaign
    @campaign = @organization.campains.friendly.find(params[:campaign_id])
  end

  def set_event
    @event = @campaign.events.friendly.find(params[:id])
  end
end
