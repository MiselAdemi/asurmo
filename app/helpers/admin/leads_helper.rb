module Admin::LeadsHelper
	def lead_status(lead)
    user = User.where(email: lead.email).first
    if user.present?
      if user.full_name == "Invited User"
        return "pending"
      else
        return "registered"
      end
    else
      return 0
    end
  end
end
