class EventPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @event = model
  end

  def show?
    @event.campain.is_accessable_by_user?(current_user)
  end

  def create?
    !current_user.events_quota_full?
  end
end
