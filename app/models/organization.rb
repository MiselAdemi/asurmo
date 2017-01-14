class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :moderators, :dependent => :destroy
  has_many :users, :through => :moderators

  accepts_nested_attributes_for :moderators, :users

  mount_uploader :avatar, OrganizationAvatarUploader
end
