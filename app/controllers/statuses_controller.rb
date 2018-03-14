class StatusesController < ApplicationController
  before_action :set_status, :only => [:show, :edit, :update, :support]
  before_action :load_statusable
  respond_to :js, :json, :html

  def index
    @statuses = @statusable.statuses
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
    @status = @statusable.statuses.new
  end

  def create
    @status = @statusable.statuses.new(status_params)
 		@status.author_id = current_user.id
 		@status.author_type = "User"

    if @status.save
      track_activity(@status)
      respond_with(@status) do |format|
        format.html { redirect_back(fallback_location: root_path) }
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
    params.require(:status).permit(:body, :user_id)
  end

  def status_id
    params.permit(:id).require(:id)
  end

  def set_status
    @status = Status.find(status_id)
  end

  def load_statusable
  	klass = [User, Organization].detect { |c| params["#{c.name.underscore}_id"] }
  	@statusable = klass.friendly.find(params["#{klass.name.underscore}_id"])
  end
end
