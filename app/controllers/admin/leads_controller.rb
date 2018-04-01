class Admin::LeadsController < Admin::BaseController
  before_action :authenticate_admin

  def index
     @leads = Lead.all
  end

end
