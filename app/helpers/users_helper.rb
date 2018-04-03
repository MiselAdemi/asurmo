module UsersHelper
  include ActionView::Helpers::DateHelper

  def is_organization_owner?(organization, user)
    organization.owner_id == user.id
  end

  def is_organization_admin?(organization)
    if Member.exists?(:user_id => current_user.id, :organization_id => organization.id)
      organization.members.where(:user_id => current_user).first.role == 'admin' ? true : false
    else
      return false
    end
  end

  def is_organization_moderator?(organization)
    if organization.members.exists?(:user_id => current_user.id, :organization_id => organization.id)
      organization.members.where(:user_id => current_user).first.role == 'moderator' ? true : false
    else
      return false
    end
  end

  def is_supporting_organization?(organization, user)
    if organization.users.exists?(user.id)
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

  def cover_image(user)
    user.cover_image.present?? user.cover_image.url : 'cover.jpg'
  end

  def avatar(user)
    user.avatar.present?? user.avatar.url : 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/1441527/1160/772/m1/fpnw/wm0/businessman-avatar-icon-01-.jpg?1468234792&s=e3a468692e15e93a2056bd848193e97a'
  end

  def self.viewable_campaigns(campaigns, user)
    public_campaigns = campaigns.collect{ |campaign| campaign if campaign.teams.empty? && campaign.participant_users.empty? }.compact[0...-1]
    private_campaigns = campaigns.collect{ |campaign| campaign if campaign.participant_users.exists?(user.id) }.compact
    public_campaigns + private_campaigns
  end
end
