class Campain < ApplicationRecord
  extend FriendlyId
  include CampainsHelper
  friendly_id :name, :use => :slugged

  belongs_to :user
  belongs_to :organization
  
  has_many :statuses, :as => :statusable
  has_many :activities
  has_many :events

  mount_uploader :avatar, CampainAvatarUploader

  def is_editable?(u)
  	campaign_index = user_campains(u).index(self) + 1
  	campaign_index <= u.active_subscription.campains_quota
  end
end
