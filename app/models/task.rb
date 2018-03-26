class Task < ApplicationRecord
  before_save :set_default_status

  belongs_to :campain
  belongs_to :user

  enum status: [:upcomming, :in_progress, :finished]

  def set_default_status
    self.status = Task.statuses.key(0)
  end
end
