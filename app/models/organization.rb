class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :members, :dependent => :destroy
  has_many :users, :through => :members
  has_many :moderators, -> { where :members => { :role => 1 } }, :through => :members, :source => :user
  has_many :admins, -> { where :members => { :role => 2 } }, :through => :members, :source => :user
  has_many :campains, :dependent => :destroy

  accepts_nested_attributes_for :members, :users

  mount_uploader :avatar, OrganizationAvatarUploader

  # add new admin
  def add_admin(user)
    member = members.where(:user => user).first
    if(member.present?)
      member.update_attributes(:role => 2)
    else
      members.create(:user => user, :role => 2)
    end
  end

  # remove admin
  def remove_admin(user)
    user.role = 0
    user.save
  end

  # add new moderator
  def add_moderator(user)
    member = members.where(:user => user).first
    if(member.present?)
      member.update_attributes(:role => 1)
    else
      members.create(:user => user, :role => 1)
    end
  end

  # remove moderator
  def remove_moderator(user)
    user.role = 0
    user.save
  end

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
