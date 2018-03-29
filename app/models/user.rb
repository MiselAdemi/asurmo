class User < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, :use => :slugged
  searchkick word_start: [:email]
  acts_as_voter

  enum role: [:user, :moderator, :organization, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :members, :class_name => "Member", :foreign_key => "user_id", :dependent => :destroy
  has_many :organizations, :through => :members, :dependent => :destroy
  has_many :conversations, :foreign_key => :sender_id

  has_many :admin_organizations, ->{ where(members: {role: 2}) }, :through => :members, source: :organization
  has_many :moderate_organizations, ->{ where(members: {role: 1}) }, :through => :members, source: :organization
  has_many :member_organizations, ->{ where(members: {role: 0}) }, :through => :members, source: :organization

  accepts_nested_attributes_for :members, :organizations

  has_many :activities
  has_many :statuses, :as => :statusable
  has_many :albums, :dependent => :destroy
  has_many :pictures
  has_many :campains

  has_many :memberships
  has_many :subscriptions_quotas, :through => :memberships

  has_many :chatroom_users
  has_many :chatrooms, :through => :chatroom_users
  has_many :messages

  has_many :interesttaggings
  has_many :interests, :through => :interesttaggings

  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user

  has_many :teamables, :dependent => :destroy
  has_many :teams, through: :teamables

  has_many :participants, dependent: :destroy
  has_many :viewable_campaigns, through: :participants, source: :campain, :dependent => :delete_all

  has_many :assignments
  has_many :assigned_tasks, through: :assignments, source: :task

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover_image, CoverPhotoUploader

  # Validation
  validates_presence_of :first_name,
                        :last_name,
                        :email
  #                      :password

  validates_uniqueness_of :email

  def full_name
    if !first_name.nil?
      first_name + " " + last_name
    else
      "Invited User"
    end
  end

  def likes?(activity)
    activity.likes.where(user_id: id).any?
  end

  def avatar_url
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end

  # is user admin of organization
  def is_organization_admin?(organization)
    organization.admins.include?(self)
  end

  # is user moderator of organization
  def is_organization_moderator?(organizatin)
    organizatin.moderators.include?(self)
  end

  def organization_role_label(organization)
    return "<label class='bg-blue-light p-2 rounded-lg text-white'>admin</label>" if self.is_organization_admin?(organization)
    return "<label class='bg-orange-light p-2 rounded-lg text-white'>moderator</label>" if self.is_organization_moderator?(organization)
    return "<label class='bg-green-light p-2 rounded-lg text-white'>member</label>"
  end

  def organization_role(organization)
    return "admin" if self.is_organization_admin?(organization)
    return "moderator" if self.is_organization_moderator?(organization)
    return "member"
  end

  # all organizations where user is admin
  def self.all_organizations_where_user_admin(user)
    Organization.joins(:members).where("members.user_id = ? AND members.role = ?", user.id, 2)
  end

  # all organizations where user is moderator
  def self.all_organizations_where_user_moderator(user)
    Organization.joins(:members).where("members.user_id = ? AND members.role = ?", user.id, 1)
  end

  # all organizations where user is member
  def self.all_organizations_where_user_member(user)
    Organization.joins(:members).where("members.user_id = ? AND members.role = ?", user.id, 0)
  end

  def subscribed?
    stripe_subscription_id?
  end

  def active_subscription
    #if subscribed?
    subscriptions_quotas.last
    #end
  end

  def used_organizations_quota
    (organizations.where(:owner_id => id).count * 100) / active_subscription.organizations_quota
  end

  def used_campains_quota
    (Organization.joins(:campains).where(:owner_id => self.id).where.not("campains.slug LIKE ?", "default%").count * 100) / active_subscription.campains_quota
  end

  def used_events_quota
    (Event.joins(campains).count * 100) / active_subscription.events_quota
  end

  def organizations_quota_full?
    active_subscription.organizations_quota <= organizations.where(:owner_id => id).count
  end

  def campains_quota_full?
    active_subscription.campains_quota <= Organization.joins(:campains).where(:owner_id => self.id).where.not("campains.slug LIKE ?", "default%").count
  end

  def events_quota_full?
    active_subscription.events_quota <= Event.joins(campains).count
  end

  def number_of_organizations_user_ownes
    organizations.where(:owner_id => id).count
  end

  def number_of_campains_user_ownes
    Organization.joins(:campains).where(:owner_id => self.id).where.not("campains.slug LIKE ?", "default%").count
  end

  def number_of_events_user_ownes
    Event.joins(campains).count
  end

  def notifications
    Notification.where(:recipient_id => id)
  end

  def unread_notifications
    Notification.where(:recipient_id => id).where(:read => false)
  end

  # Tagging methods
  def self.interested_in(name)
    Interest.find_by_name!(name).users
  end

  def self.interest_count
    Interest.select("interests.*, count(interesttaggings.interest_id) as count").
    joins(:interesttaggings).group("interesttaggings.interest_id")
  end

  def interest_list
    interests.map(&:name).join(", ")
  end

  def interest_list=(names)
    self.interests = names.split(", ").map do |n|
      Interest.where(:name => n.strip).first_or_create!
    end
  end

  def active_for_authentication?
    super && !self.blocked
  end

  # to call all your friends
  def friends
    active_friends | received_friends
  end

  # to call your pending sent or received
  def pending
    pending_friends | requested_friendships
  end

  def pending?(user)
    pending_friends.where(:id => user.id).first.present?
  end

  def is_friend?(user)
    active_friends.where(:id => user.id).first.present?
  end

  def self.search_poeple(term)
    where('LOWER(first_name) LIKE :term OR LOWER(last_name) LIKE :term', term: "#{term.downcase}%")
  end

  def online?
    updated_at > 10.minutes.ago
  end
end
