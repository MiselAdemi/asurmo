module UsersHelper

  def is_organization_owner?(organization)
    if Member.exists?(:user_id => current_user.id)
      organization.members.where(:user_id => current_user).first.role == 'owner' ? true : false
    else
      return false
    end
  end

  def is_supporting_organization?(organization, user)
    if organization.users.exists?(current_user)
      return true
    else
      return false
    end
  end

  def is_member?(organization, user)
    if organization.members.exists?(:user_id => user)
      organization.members.where(:user_id => user).first.role == 'member' ? true : false
    else
      return false
    end
  end
end
