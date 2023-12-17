class Api::V1::SuggestionsController < ApplicationApiController
  protect_from_forgery

  def suggest
    player = Player.find(suggestion_params[:player_id])
    suggestions = SuggestionGenerator.new(player).suggestions
    offers = OffersFormatter.from_suggestions(suggestions)
    render json: offers
  end

  private

  def suggestion_params
    params.permit(:player_id, suggestion:{})
  end

end