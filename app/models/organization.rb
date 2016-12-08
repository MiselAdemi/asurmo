class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :moderators
  has_many :users, :through => :moderators

  accepts_nested_attributes_for :moderators, :users
end
