class Administrator::ParticipantsController < Administrator::BaseController
  before_action :authenticate_admin

  def index
    # @teams = @organization.teams
  end

  def show
  end

  def new
    # @team = @organization.teams.new
  end

  def create
    # @team = @organization.teams.build(team_params)
    #
    # respond_to do |format|
    #   if @team.save
    #     format.html { redirect_back(fallback_location: root_path, notice: 'Team was successfully created.' ) }
    #     format.json { render :json => @team.as_json }
    #   else
    #     render 'new', :notice => "Unable to create new team"
    #   end
    # end
  end

  def edit
  end

  def update
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_user
    @user = @organization.users.friendly.find(params[:user_id])
  end
end
