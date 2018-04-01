class LeadsController < ApplicationController
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to root_path, notice: "You are added on the waiting list for early access!"
    else
      redirect_to root_path
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:email)
  end
end
