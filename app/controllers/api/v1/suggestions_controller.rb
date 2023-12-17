class Api::V1::SuggestionsController < ApplicationApiController
  protect_from_forgery

  def suggest
    player = Player.find(suggestion_params[:player_id])
    if player == current_player
      suggestions = SuggestionGenerator.new(player).suggestions
      offers = OffersFormatter.from_suggestions(suggestions)
      render json: offers
    else
      return respond_with_error('unauthorized', nil, "Please log in to continue.")
    end
  end

  private

  def suggestion_params
    params.permit(:player_id, suggestion:{})
  end

end