module TeamsHelper
  def teams_of_user(organization, user)
    Team.joins(:users).where(users: { id: user.id}).where('organization_id = ?', organization.id)
  end

  def not_teams_of_user(organization, user)
    teams_id = user.teams.where(organization_id: organization.id).pluck(:id)
    organization.teams.where("id not in (?)", teams_id)
  end
end
