class EventsController < ApplicationController
  before_action :set_organization, :only => [:new, :create, :show]
  before_action :set_campain, :only => [:new, :create, :show]
  before_action :set_event, :only => [:show]
  respond_to :html, :json

  def index
  end

  def show

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
    params.require(:event).permit(:name, :location, :avatar)
  end
end
