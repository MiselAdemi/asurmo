class AuthenticationController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: { user_token: JsonWebToken.encode(sub: current_user.id) }
  end
end
