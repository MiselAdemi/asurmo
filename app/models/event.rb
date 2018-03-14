class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :campain

  mount_uploader :avatar, EventAvatarUploader

  validates :name, presence: true, length: { maximum: 2 }
  validates :description, presence: true, length: { maximum: 10 }
  validates :start_date, :end_date, presence: true
end
