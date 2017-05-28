class Status < ApplicationRecord
  acts_as_commentable
  after_create :notified_users

  #belongs_to :user
  belongs_to :statusable, polymorphic: true
  
  def notified_users
    mentioned_users.each do |user|
      Notification.create(recipient: user, user: User.find(self.author_id), action: "mentioned", notifiable: user)
  	end
  end
  
  def mentions
  @mentions ||= begin
										regex = /@([\w]+[\-][\w]+)/
										matches = body.scan(regex).flatten
									end
  end
  
  def mentioned_users
  	@mentioned_users ||= User.where(slug: mentions)
  end
end
