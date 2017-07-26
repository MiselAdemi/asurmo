class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, :with => :user_not_authorized
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
    if resource.blocked
      sign_out resource
      root_path
    end

		stored_location_for(resource) || user_path(current_user)
	end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
    end

  private
    def user_not_authorized
      flash[:alert] = "Access denied"
      redirect_to (request.referrer || root_path)
    end

    def track_activity(trackable, action = params[:action])
      determine_type
      current_user.activities.create!(:action => action, :trackable => trackable, :to_id => @to, :from_type => "user", :to_type => @to_type)
    end

    def untrack_activity(trackable, action = params[:action])
      activity = current_user.activities.where(:trackable => trackable).first
      Activity.destroy(activity.id) if activity
    end

    def determine_type
      if(params[:event_id].present?)
        @to_type = "event"
        @to = Event.friendly.find(params[:event_id]).id
    	elsif(params[:campain_id].present?)
      	@to_type = "campain"
        @to = Campain.friendly.find(params[:campain_id]).id
      elsif(params[:organization_id].present?)
        @to_type = "organization"
        @to = Organization.friendly.find(params[:organization_id]).id
      elsif(params[:user_id].present?)
        @to_type = "user"
        @to = User.friendly.find(params[:user_id]).id
      else
        @to_type = "user"
        @to = current_user.id
      end
    end
end
