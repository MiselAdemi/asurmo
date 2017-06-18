class FriendshipsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_friendship, :only => [:update, :destroy]

	def create
		@friendship = current_user.friendships.build(friend_id: params[:friend_id])
		if @friendship.save
			flash[:notice] = "Friend requested."
			redirect_to :back
		else
			flash[:error] = "Unable to request friendship."
			redirect_to :back
		end
	end

	def update
		@friendship.update(accepted: true)
		if @friendship.save
			redirect_to :back, notice: "Successfully confirmed friend!"
		else
			redirect_to :back, notice: "Sorry! Could not confirm friend!"
		end
	end

	def destroy
		@friendship.destroy
		flash[:notice] = "Removed friendship."
		redirect_to :back
	end

	private

	def find_friendship
		@friendship = Friendship.where(:friend_id => current_user.id).where(:user_id => params[:id]).first
	end
end
