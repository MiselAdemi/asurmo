class Organization < ActiveRecord::Base
  has_many :moderators
  has_many :users, :through => :moderators

  accepts_nested_attributes_for :moderators, :users
end
