class HomePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @home = model
  end

  def index?
    user_signed_in?
  end
end
