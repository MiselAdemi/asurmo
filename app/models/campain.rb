class Campain < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :user
  belongs_to :organization
  
  has_many :statuses, :as => :statusable
  has_many :activities
  has_many :events

  mount_uploader :avatar, CampainAvatarUploader
end
