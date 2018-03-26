class Campain < ApplicationRecord
  extend FriendlyId
  include CampainsHelper
  friendly_id :name, :use => :slugged
  attr_readonly :name

  belongs_to :user
  belongs_to :organization

  has_many :statuses, :as => :statusable
  has_many :activities
  has_many :events, dependent: :destroy
  has_many :tasks, dependent: :destroy

  has_many :participants
  has_many :participant_users, through: :participants, source: :user, :dependent => :delete_all

  has_and_belongs_to_many :teams

  accepts_nested_attributes_for :events

  mount_uploader :avatar, CampainAvatarUploader

  def is_editable?(u)
  	# campaign_index = user_campains(u).index(self) + 1
  	# campaign_index <= u.active_subscription.campains_quota
    true
  end

  def is_accessable_by_user?(user)
    if self.participant_users.empty?
      return true
    else
      self.participant_users.exists?(user.id)
    end
  end
end
