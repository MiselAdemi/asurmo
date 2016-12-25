class StatusesController < ApplicationController
  respond_to :html, :json

  def index
  end

  def edit
  end

  def update
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

  private

  def status_params
    params.require(:status).permit(:body)
  end
end
