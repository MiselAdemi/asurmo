class Status < ApplicationRecord
  acts_as_commentable
  #after_create :notified_users

  belongs_to :user
  
  #def notified_users
  #	mentioned_users.each do |user|
  		# notify mentioned users
  #	end
  #end
  
  def mentions
  @mentions ||= begin
										regex = /@([\w]+[\-][\w]+)/
										matches = body.scan(regex).flatten
									end
  end
  
  def mentioned_users
  	@mentioned_users ||= User.where(first_name: mentions)
  end
end
