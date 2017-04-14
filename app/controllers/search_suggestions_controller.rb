class SearchSuggestionsController < ApplicationController

  def index
    render json: SearchSuggestion.terms_for(params[:term], organization_params)
  end

  private

  def organization_params
    params.permit(:organization_id)
  end
end
