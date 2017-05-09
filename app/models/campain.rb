class Campain < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :user
  belongs_to :organization

  has_many :events
end
