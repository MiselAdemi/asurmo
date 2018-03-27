class Task < ApplicationRecord
  acts_as_commentable
  before_save :set_default_status

  belongs_to :campain
  belongs_to :user

  has_many :assignments
  has_many :assignees, through: :assignments, source: :user

  enum status: [:upcomming, :in_progress, :finished]

  def set_default_status
    self.status = Task.statuses.key(0)
  end
end
