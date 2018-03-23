class Administrator::MembersController < Administrator::BaseController
  before_action :authenticate_admin
  before_action :set_member, only: [:change_role]

  def change_role
    @member.update_attributes(:role => Member.roles.key(params[:role_id].to_i))
    redirect_back(fallback_location: root_path)
  end

  private

  def set_member
    @member = @organization.members.where(user_id: params[:user_id]).first
  end
end
