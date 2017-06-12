module OrganizationsHelper

	def all_active_organization_from_user(user)
		user.organizations.where(:removed => false)
	end

end
