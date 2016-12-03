class OrganizationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @organization = model
  end

  def edit?
    user_is_moderator_or_owner
  end

  def update?
    user_is_moderator_or_owner
  end

  private
  def user_is_moderator_or_owner
    # User is owner or moderator
    @organization.moderators.map(&:user_id).include?(current_user.id) && (@organization.moderators.map(&:role).include?("moderator") || @organization.moderators.map(&:role).include?("owner"))
  end
end
