class Admin::LeadsController < Admin::BaseController
  before_action :authenticate_admin
  before_action :set_lead, only: [ :invite ]

  def index
     @leads = Lead.all
  end

  def invite
    User.invite!(:email => @lead.email)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_lead
    @lead = Lead.find(params[:lead_id])
  end
end
