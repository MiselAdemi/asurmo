class Administrator::OrganizationsController < Administrator::BaseController
  before_action :authenticate_admin

  def edit
  end

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_back(fallback_location: root_path, notice: 'Organization was successfully updated.' ) }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :description, :avatar, :cover_image)
  end
end
