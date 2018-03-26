class CampainPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @campaign = model
  end

  def show?
    @campaign.is_accessable_by_user?(current_user)
  end

  def create?
    !current_user.campains_quota_full?
  end
end
