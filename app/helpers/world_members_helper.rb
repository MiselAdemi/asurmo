module WorldMembersHelper
	def prepare_new_member(member_params)
		if User.exists?(email: member_params[:email])
			user = User.find_by(email: member_params[:email])
			WorldMember.new(first_name: user.first_name, 
											last_name: user.last_name, 
											email: user.email, 
											country_code: user.country_code,
											city_id: user.city_id,
											zip_code: user.zip_code)
		else
			WorldMember.new(member_params)
		end
	end

	def update_world_member(member_params, user)
		if WorldMember.exists?(email: user.email)
			@member = WorldMember.find_by(email: user.email)
			@member.update_attributes(member_params)
		end
	end
end