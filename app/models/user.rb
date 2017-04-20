class User < ActiveRecord::Base
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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :members, :class_name => "Member", :foreign_key => "user_id", :dependent => :destroy
  has_many :organizations, :through => :members
  has_many :conversations, :foreign_key => :sender_id

  accepts_nested_attributes_for :members, :organizations

  has_many :activities
  has_many :interests_list
  has_many :interests, :through => :interests_list
  has_many :statuses
  has_many :albums
  has_many :pictures
  has_many :campains

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover_image, CoverPhotoUploader

  # Validation
  validates_presence_of :first_name,
                        :last_name,
                        :email,
                        :password

  validates_uniqueness_of :email

  def full_name
    first_name + " " + last_name
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
end
