class Task < ApplicationRecord
  acts_as_commentable
  after_create :set_default_status

  belongs_to :campain
  belongs_to :user

  has_many :assignments
  has_many :assignees, through: :assignments, source: :user

  enum status_type: [:upcomming, :in_progress, :finished]

  def set_default_status
    self.status = Task.status_types.key(0)
    self.save
  end
end
