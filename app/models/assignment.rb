class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def self.notify_user(assignee, admin)
    Notification.create(recipient: assignee, user: User.find(admin.id), action: "assigned", notifiable: assignee)
  end
end
