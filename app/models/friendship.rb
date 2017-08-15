class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	after_create :notify_user

	def notify_user
		Notification.create(recipient: self.friend, user: User.find(self.user.id), action: "friend_request", notifiable: self.friend)
	end
end
