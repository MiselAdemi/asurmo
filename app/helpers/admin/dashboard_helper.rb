module Admin::DashboardHelper
	def total_users_count
		User.count
	end

	def total_organizations_count
		Organization.count
	end
end
