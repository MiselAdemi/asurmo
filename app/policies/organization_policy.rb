class OrganizationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @organization = model
  end

  def create?
    !current_user.organizations_quota_full?
  end

  def edit?
    current_user.is_organization_admin?(@organization) || current_user.is_organization_moderator?(@organization)
  end

  def update?
    current_user.is_organization_admin?(@organization) || current_user.is_organization_moderator?(@organization)
  end

  def destroy?
    current_user.is_organization_admin?(@organization)
  end
end
