class ModeratorPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @moderators = model
    puts @moderators
  end

  def index?
    @moderators.map(&:user_id).include?(current_user.id)
  end
end
