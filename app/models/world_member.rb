class WorldMember < ApplicationRecord
	has_many :organizations

	def is_platform_member?
		User.exists?(email: self.email)
	end
end