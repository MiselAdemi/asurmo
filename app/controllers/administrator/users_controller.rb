class Administrator::UsersController < Administrator::BaseController
  before_action :authenticate_admin

  def index
    @users = @organization.users
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
