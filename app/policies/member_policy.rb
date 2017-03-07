class MemberPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @member = model
  end

  def index?
    @member.map(&:role).include?("owner")
  end

  def new?
    @member.map(&:role).include?("owner")
  end

  def create?
    @member.map(&:role).include?("owner")
  end
end

