class HomeController < ApplicationController
  def index
    if user_signed_in?
      @activities = Activity.where("user_id = ? OR to_id = ?", current_user.id, current_user.id).order(:created_at => :desc).page(params[:page]).per(4)
      @notifications = Notification.where(:recipient => current_user).limit(8)
      @status = current_user.statuses.new
      @album = current_user.albums.find_or_create_by(title: "Uncategorized")
      @picture = @album.pictures.new
    end
  end

  def get_cities
    @country_code = params[:country_code]
    @country_code = @country_code.downcase
    @cities = Location.where("country = ?", @country_code).where("population > ?", 30000)
  end

  def invite_user

  	UserMailer.invite(params[:invite_email], current_user).deliver

  	redirect_to :back
  end
end
