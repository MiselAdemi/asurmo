class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :campain

  mount_uploader :avatar, EventAvatarUploader
end
