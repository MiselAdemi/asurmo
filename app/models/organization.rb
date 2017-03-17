class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :members, :dependent => :destroy
  has_many :users, :through => :members
  has_many :moderators, -> { where :role => 1 }, :through => :members
  has_many :admins, -> { where :role => 2 }, :through => :members
  has_many :campains

  accepts_nested_attributes_for :members, :users

  mount_uploader :avatar, OrganizationAvatarUploader

  # User joins organization
  def join(user)
    members.create(:user => user, :role => 0)
  end

  # User exit organization
  def exit(user)
    members.find_by(:user => user).destroy
  end

  # is following
  def member?(user)
    members.include?(user)
  end
end
