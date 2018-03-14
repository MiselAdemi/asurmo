module CampainsHelper
	def user_campains(user)
		organizations = Organization.joins(:campains).where(:owner_id => user.id)
		campains = organizations.map { |o| o.campains }.flatten
	end

	def campaign_avatar(campaign)
		campaign.avatar.present?? campaign.avatar.url : 'avatar.jpg'
	end
end
