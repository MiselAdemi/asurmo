class Administrator::TasksController < Administrator::BaseController
  before_action :authenticate_admin
  before_action :set_campaign, only: [ :show, :new, :create, :edit, :update, :destroy, :assign_user, :remove_assignee ]
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :assign_user, :remove_assignee ]

  def index
  end

  def show
    @comments = @task.root_comments.order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @task = @campaign.tasks.new
  end

  def create
    @task = @campaign.tasks.build(task_params)
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_back(fallback_location: root_path, notice: 'Task was successfully created.' ) }
        format.json { render :json => @task.as_json }
      else
        render 'new', :notice => "Unable to create new campaign"
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_back(fallback_location: root_path, notice: 'Task was successfully updated.' ) }
        format.json { head :ok }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to edit_administrator_organization_campaign_path(@organization, @campaign)
  end

  def assign_user
    email = params[:assignee].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i).first

    if @campaign.participant_users.exists?(User.where(email: email).first.id)
      if !@task.assignees.exists?(@campaign.participant_users.where(email: email).first.id)
        @task.assignees << @campaign.participant_users.where(email: email).first
        Assignment.notify_user(@campaign.participant_users.where(email: email).first, current_user)
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def remove_assignee
    @task.assignees.delete(@task.assignees.find(params[:user_id]))
    redirect_back(fallback_location: root_path)
  end

  def complete
    @campaign.tasks.find(params[:task_id])
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :start_date, :end_date, :status, :user_id)
  end

  def set_campaign
    @campaign = @organization.campains.friendly.find(params[:campaign_id])
  end

  def set_task
    @task = @campaign.tasks.find(params[:id])
  end
end
