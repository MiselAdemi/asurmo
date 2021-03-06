class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged
  acts_as_commentable

  belongs_to :campain

  mount_uploader :avatar, EventAvatarUploader

  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :start_date, :end_date, presence: true
end
