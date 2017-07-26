class RegistrationsController < Devise::RegistrationsController

	protected

	def after_sign_up_path_for(resource)
    plan = Plan.where(name: "free").first

    subs = current_user.subscriptions_quotas.create(:plan => plan.name, 
                                  :organizations_quota => plan.organizations_quota,
                                  :campains_quota => plan.campains_quota,
                                  :events_quota => plan.events_quota)

    subs.save

    stored_location_for(resource) || user_path(current_user)
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :coutry_code, :city_id)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :coutry_code, :city_id)
  end
end
