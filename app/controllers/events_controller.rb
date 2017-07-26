class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_organization, :only => [:index, :campain_events, :new, :create, :show, :destroy]
  before_action :set_campain, :only => [:new, :create, :show, :destroy]
  before_action :set_event, :only => [:destroy, :show]
  before_action :set_status, :only => [:show]
  respond_to :html, :json

  def index
    @events = @organization.campains.map { |campain| campain.events }.flatten
    @campain = @organization.campains.new
    @default_campain = @organization.campains.first
    @event = @default_campain.events.new
    @campains = @organization.campains
  end

  def campain_events
    @events = @organization.campains.map { |campain| campain.events }.flatten
    @campain = @organization.campains.new
    @default_campain = @organization.campains.first
    @event = @default_campain.events.new
    @campains = @organization.campains
  end

  def show
    @activities = Activity.where("to_id = ? AND to_type = ?", @event.id, "event").order(:created_at => :desc).page(params[:page]).per(2)
  end

  def new
    @event = @campain.events.new
  end

  def create
    @event = @campain.events.build(event_params)

    if @event.save
      respond_with(@event) do |format|
        format.html { redirect_to organization_campain_event_path(@organization, @campain, @event) }
        format.json { render :json => @campain.as_json }
      end
    else
      render "new", :notice => "Unable to create new event"
    end
  end

  def destroy
    @event.destroy
    redirect_to :back
  end

  private

  def set_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def set_campain
    @campain = Campain.friendly.find(params[:campain_id])
  end

  def set_event
    @event = @campain.events.friendly.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :location, :avatar, :description, :start_date, :end_date)
  end

  def set_user
    @user = current_user
  end

  def set_status
    @status = @organization.statuses.new
  end
end
