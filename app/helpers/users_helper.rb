module UsersHelper
  include ActionView::Helpers::DateHelper

  def is_organization_owner?(organization)
    if Member.exists?(:user_id => current_user.id, :organization_id => organization.id)
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

  # last time active
  def last_time_active(user)
    time = Time.now.to_i - user.current_sign_in_at.to_time.to_i
    distance_of_time_in_words(user.current_sign_in_at.to_time, Time.now)
  end
end
