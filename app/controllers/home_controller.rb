class HomeController < ApplicationController
  def index
  end

  def get_cities
    @country_code = params[:country_code]
    @country_code = @country_code.downcase
    @cities = Location.where("country = ?", @country_code).where("population > ?", 30000)
  end

  def invite_user
  	
  	UserMailer.invite(params[:invite_email]).deliver

  	redirect_to :back
  end
end