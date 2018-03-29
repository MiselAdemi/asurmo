class Administrator::Organizations::MembersController < Administrator::BaseController
  before_action :authenticate_admin

  def create
    organization_user = @organization.members.new(member_params)
    organization_user.organization = @organization

    if organization_user.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

  private

  def member_params
    params.require(:member).permit(:email)
  end
end
