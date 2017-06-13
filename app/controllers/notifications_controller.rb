class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def index 
  	@notifications = Notification.where(recipient: current_user)
  end 

	def mark_as_read
		@notifications = Notification.where(:recipient_id => current_user).where(:read => false)
		@notifications.update_all(:read => true)
		render json: { success: true }
	end

end
