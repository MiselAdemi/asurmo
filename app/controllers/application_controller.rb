class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, :with => :user_not_authorized
  protect_from_forgery with: :exception

	def after_sign_in_path_for(resource)
		stored_location_for(resource) || organizations_path
	end

  private
    def user_not_authorized
      flash[:alert] = "Access denied"
      redirect_to (request.referrer || root_path)
    end

    def track_activity(trackable, action = params[:action])
      current_user.activities.create!(:action => action, :trackable => trackable)
    end

    def untrack_activity(trackable, action = params[:action])
      activity = current_user.activities.where(:trackable => trackable).first
      Activity.destroy(activity.id)
    end
end
