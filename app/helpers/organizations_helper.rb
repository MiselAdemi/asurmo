module OrganizationsHelper

	def all_active_organization_from_user(user)
		user.organizations.where(:removed => false)
	end

	def update_world_members(organization)
		organization.members.each do |member|
			if !organization.world_members.map(&:email).include?(member.user.email)
				organization.world_members.create(first_name: member.user.first_name,
																					last_name: member.user.last_name,
																					email: member.user.email,
																					country_code: member.user.country_code,
																					city_id: member.user.city_id,
																					zip_code: member.user.zip_code)
			elsif organization.world_members.map(&:email).include?(member.user.email)
				user = WorldMember.find_by(email: member.user.email)
				user.update(first_name: member.user.first_name,
										last_name: member.user.last_name,
										email: member.user.email,
										country_code: member.user.country_code,
										city_id: member.user.city_id,
										zip_code: member.user.zip_code)
			end
		end
	end

	def self.publicity_label(campaign)
		return '<label class="bg-transparent border p-1 text-xs rounded-lg text-grey-darker absolute pin-r pin-t mt-4 mr-4">Public</label>' if campaign.teams.empty? && campaign.participant_users.empty?
		return '<label class="bg-transparent border border-orange-dark p-1 text-xs rounded-lg text-orange-dark absolute pin-r pin-t mt-4 mr-4">Private</label>'
	end
end
