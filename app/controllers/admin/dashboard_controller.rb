class Admin::DashboardController < Admin::BaseController
  layout "admin_dashboard"
  before_action :authenticate_admin

  def index
  end
end
