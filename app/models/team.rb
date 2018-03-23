class Team < ApplicationRecord
  belongs_to :organization

  has_many :teamables, :dependent => :destroy
  has_many :users, through: :teamables

  has_many :participants, as: :viewable, dependent: :destroy
  has_many :campaigns, through: :participants, source: :viewable, source_type: "Campain"

  has_and_belongs_to_many :campains
end
