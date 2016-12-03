class ModeratorPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @moderator = model
  end

  def index?
    @moderator.map(&:role).include?("owner")
  end

  def new?
    @moderator.map(&:role).include?("owner")
  end

  def create?
    @moderator.map(&:role).include?("owner")
  end
end

