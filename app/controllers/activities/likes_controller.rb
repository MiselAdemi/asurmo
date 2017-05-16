class Activities::LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_activity

	def create
		@activity.likes.where(user_id: current_user.id).first_or_create

		respond_to do |format|
			format.html { redirect_to user_path(current_user) }
			format.js
		end
	end

	def destroy
		@activity.likes.where(user_id: current_user.id).destroy_all

		respond_to do |format|
			format.html { redirect_to user_path(current_user) }
			format.js
		end
	end

	private

		def set_activity
			@activity = Activity.find(params[:activity_id])
		end
end