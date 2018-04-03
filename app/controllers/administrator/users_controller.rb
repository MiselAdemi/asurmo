class Administrator::UsersController < Administrator::BaseController
  before_action :authenticate_admin

  def index
    @users = Organization.user_search(@organization.id, params[:keywords], params[:role])
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
