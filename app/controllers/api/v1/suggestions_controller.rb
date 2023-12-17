class Api::V1::SuggestionsController < ApplicationApiController
  protect_from_forgery

  def suggest
    ap suggestion_params
    player = Player.find(suggestion_params[:player_id])
    suggestions = SuggestionGenerator.new(player).suggestions
    offers = OffersFormatter.from_suggestions(suggestions)
    # return respond_with_error('unauthorized', nil, "Please log in to continue.") if !player_signed_in?
    # offer = Offer.find(claim_params['id'])
    # result = OfferClaimer.call(player: current_player, offer: offer)
    render json: offers
  end

  private

  def suggestion_params
    params.permit(:player_id, suggestion:{})
  end

end