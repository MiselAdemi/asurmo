class StatusesController < ApplicationController
  before_action :set_status, :only => [:show, :edit, :update, :support]
  respond_to :js, :json, :html

  def index
    @statuses = current_user.statuses
    render :json => @statuses.as_json
  end

  def show
    render :json => @status.as_json
  end

  def edit
  end

  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to current_user }
        format.json { render :json => @status.as_json }
      else
        format.html { redirect_to current_user }
        format.json { render :json => @status.errors }
      end
    end
  end

  def new
    @status = current_user.statuses.new
  end

  def create
    @status = current_user.statuses.build(status_params)

    if @status.save
      track_activity(@status)
      respond_with(@status) do |format|
        format.html { redirect_to current_user }
        format.json { render :json => @status.as_json }
      end
    else
      render "new", :notice => "Unable to save status"
    end
  end

  def destroy
  end

  def support
    if !current_user.liked?(@status)
      @status.liked_by(current_user)
    else
      @status.unliked_by(current_user)
    end
    sync_update Activity.where(:trackable => @status)
  end

  private

  def status_params
    params.require(:status).permit(:body, :user_id, :id)
  end

  def status_id
    params.permit(:id).require(:id)
  end

  def set_status
    @status = Status.find(status_id)
  end
end
