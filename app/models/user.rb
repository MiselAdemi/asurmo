class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, :use => :slugged

  enum role: [:user, :moderator, :organization, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :members
  has_many :organizations, :through => :members

  accepts_nested_attributes_for :members, :organizations

  has_many :activities
  has_many :interests_list
  has_many :interests, :through => :interests_list
  has_many :statuses
  has_many :albums
  has_many :pictures
  has_many :campains

  def full_name
    first_name + " " + last_name
  end

  mount_uploader :avatar, AvatarUploader
end
