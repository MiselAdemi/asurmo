class WorldMember < ApplicationRecord
	has_many :organizations

	def is_platform_member?
		User.exists?(email: self.email)
	end

	def is_organization_owner?(owner)
		user = User.find(owner)
		self.email == user.email
	end
end