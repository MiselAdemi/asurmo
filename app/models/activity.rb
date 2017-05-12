class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  has_many :likes
end
