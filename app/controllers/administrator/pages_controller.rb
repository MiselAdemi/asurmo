class Administrator::PagesController < Administrator::BaseController
  before_action :authenticate_admin

  def dashboard
  end
end
