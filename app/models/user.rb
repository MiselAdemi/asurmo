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

  accepts_nested_attributes_for :members, :organizations

  has_many :activities
  has_many :interests_list
  has_many :interests, :through => :interests_list
  has_many :statuses, :as => :statusable
  has_many :albums, :dependent => :destroy
  has_many :pictures
  has_many :campains
  
  has_many :memberships
  has_many :subscriptions_quotas, :through => :memberships

  has_many :chatroom_users
  has_many :chatrooms, :through => :chatroom_users
  has_many :messages

  has_many :notifications, :as => :recipient

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover_image, CoverPhotoUploader

  # Validation
  validates_presence_of :first_name,
                        :last_name,
                        :email
  #                      :password

  validates_uniqueness_of :email

  def full_name
    first_name + " " + last_name
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
    byebug
    if subscribed?
      subscriptions_quotas.last
    end
  end

  def used_organizations_quota
    (organizations.count * 100) / active_subscription.organizations_quota
  end

  def used_campains_quota
    (Organization.joins(:campains).where(:owner_id => self.id).where.not("campains.slug LIKE ?", "default%").count * 100) / active_subscription.campains_quota
  end

  def used_events_quota
    (Event.joins(campains).count * 100) / active_subscription.events_quota
  end

  def organizations_quota_full?
    active_subscription.organizations_quota == organizations.count
  end

  def campains_quota_full?
    active_subscription.campains_quota == Organization.joins(:campains).where(:owner_id => self.id).where.not("campains.slug LIKE ?", "default%").count
  end

  def events_quota_full?
    active_subscription.events_quota == Event.joins(campains).count
  end

  def number_of_organizations_user_ownes
    organizations.count
  end

  def number_of_campains_user_ownes
    Organization.joins(:campains).where(:owner_id => self.id).where.not("campains.slug LIKE ?", "default%").count
  end

  def number_of_events_user_ownes
    Event.joins(campains).count
  end
end
