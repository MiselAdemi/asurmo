module CampainsHelper
	def user_campains(user)
		organizations = Organization.joins(:campains).where(:owner_id => user.id)
		campains = organizations.map { |o| o.campains }.flatten
	end

	def campaign_avatar(campaign)
		campaign.avatar.present?? campaign.avatar.url : 'avatar.jpg'
	end

	def self.update_team(campaign, team_id)
		if team_id.present?
			if campaign.teams.empty?
				campaign.teams << Team.find(team_id)
			else
				if campaign.teams.first.id == team_id
					return
				else
					old_team_id = campaign.teams.first.id
					campaign.teams.delete_all
					campaign.teams << Team.find(team_id)
					update_team_users(campaign, old_team_id)
				end
			end
		end
	end

	def self.update_team_users(campaign, old_team_id)
		old_team_users = campaign.organization.teams.find(old_team_id).users.pluck(:id)
		new_team_users = campaign.teams.first.users.pluck(:id)

		user_to_delete = old_team_users - new_team_users
		user_to_delete.each do |u|
			campaign.participant_users.delete(campaign.organization.users.find(u))
		end

		new_team_users.each do |user|
			if !campaign.participant_users.exists?(user)
				campaign.participant_users << campaign.organization.users.find(user)
			end
		end
	end

	def self.update_viewable_users(campaign, users_id)
		if users_id.present?
			user_array = users_id.delete(' ').split(",").map(&:to_i)
			user_to_delete = campaign.participant_users.pluck(:id) - user_array
			user_to_delete = user_to_delete - campaign.teams.first.users.pluck(:id) if !campaign.teams.empty?

			user_to_delete.each do |u|
				campaign.participant_users.delete(campaign.organization.users.find(u))
			end

			user_array.each do |user|
				if !campaign.participant_users.exists?(user)
					campaign.participant_users << campaign.organization.users.find(user)
				end
			end
		end
	end

	def self.users_outside_team(campaign)
		if campaign.teams.empty?
			campaign.participant_users.pluck(:id).join(', ')
		else
			(campaign.participant_users - campaign.teams.first.users).pluck(:id).join(', ')
		end

		# return (campaign.participant_users).pluck(:id).join(', ') if !campaign.participant_users.empty?
		# return (campaign.participant_users - campaign.teams.first.users).pluck(:id).join(', ') if !campaign.participant_users.empty? && !campaign.teams.empty?
	end
end
