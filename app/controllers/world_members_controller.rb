class WorldMembersController < ApplicationController
	  include WorldMembersHelper
	before_action :find_organization
	before_action :find_member, :only => [:destroy]

	def new
	end

	def create
		@user = prepare_new_member(member_params)
		@user.organization_id = @organization.id
		@organization.world_members << @user

		if @user.save
			redirect_to organization_show_members_path(@organization)
		else
			redirect_to organization_show_members_path(@organization)
		end
	end

	def destroy
		@member.destroy
		redirect_to organization_show_members_path(@organization)
	end

	def open_info_modal
  	@member = WorldMember.find(params[:world_member_id])
	  respond_to do |format|
	    format.js
	  end
	end

	def send_to_all
		UserMailer.send_multiple(params[:recipients], current_user, params[:message_body]).deliver

  	redirect_to :back
	end

	private

	def member_params
		params.require(:world_member).permit(:first_name, :last_name, :email, :country_code, :city_id, :zip_code)
	end

	def find_organization
		@organization = Organization.friendly.find(params[:organization_id])
	end

	def find_member
		@member = WorldMember.find(params[:id])
	end
end
