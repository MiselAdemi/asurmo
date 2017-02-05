class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :members, :dependent => :destroy
  has_many :users, :through => :members

  accepts_nested_attributes_for :members, :users

  mount_uploader :avatar, OrganizationAvatarUploader
end
