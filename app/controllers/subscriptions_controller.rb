class SubscriptionsController < ApplicationController
	before_action :authenticate_user!, :except => [:index, :new]
	before_action :redirect_to_signup, :only => [:new]
	before_action :find_user
	before_action :plan_name, :only => [:update_plan]


	def show

	end

	def new
		
	end

	def create
		customer = if current_user.stripe_id?
								 Stripe::Customer.retrieve(current_user.stripe_id)
							 else
								 Stripe::Customer.create(email: current_user.email)
							 end

		
		subscription = customer.subscriptions.create(
			source: params[:stripeToken],
			plan: params[:plan_name]
		)

		options = {
			stripe_id: customer.id,
			stripe_subscription_id: subscription.id,
		}

		options.merge!(
			card_last4: params[:card_last4],
			card_exp_month: params[:card_exp_month],
			card_exp_year: params[:card_exp_year],
			card_type: params[:card_brand]
		) if params[:card_last4]

		current_user.update(options)

		subs = current_user.subscriptions_quotas.create(:organizations_quota => selected_plan.organizations_quota,
																	:campains_quota => selected_plan.campains_quota,
																	:events_quota => selected_plan.events_quota)
		subs.save
		
		redirect_to user_organizations_path(current_user)
	end

	def update_plan
		customer = Stripe::Customer.retrieve(current_user.stripe_id)
		subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
		subscription.plan = plan_name + "_monthly"
		subscription.save

		subs = current_user.subscriptions_quotas.last.update(:plan => plan_name, 
																	:organizations_quota => selected_plan.organizations_quota,
																	:campains_quota => selected_plan.campains_quota,
																	:events_quota => selected_plan.events_quota)

		redirect_to subscriptions_path
	end

	def destroy
		customer = Stripe::Customer.retrieve(current_user.stripe_id)
		customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
		current_user.update(stripe_subscription_id: nil)

		plan = Plan.where(name: "free").first

		current_user.subscriptions_quotas.last.update(:plan => plan.name, 
																	:organizations_quota => plan.organizations_quota,
																	:campains_quota => plan.campains_quota,
																	:events_quota => plan.events_quota)


		redirect_to root_path, notice: "Your subscription has been canceled."
	end

	private

	def selected_plan
		Plan.where(:name => params[:plan_name].split("_")[0]).first
	end

	def redirect_to_signup
		if !user_signed_in?
			session["user_return_to"] = new_subscription_path
			redirect_to new_user_registration_path
		end
	end

	def find_user
		@user = current_user
	end

	def plan_name
		params.permit(:plan_name).require(:plan_name)
	end
end
