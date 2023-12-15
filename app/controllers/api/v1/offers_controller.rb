class Api::V1::OffersController < ApplicationApiController
  protect_from_forgery only: [:claim]

  def claim
    return respond_with_error('unauthorized', nil, "Please log in to continue.") if !player_signed_in?
    offer = Offer.find(claim_params['id'])
    result = OfferClaimer.call(player: current_player, offer: offer)
    render json: result
  end

  private

  def claim_params
    params.permit(:id, offer: {})
  end

end