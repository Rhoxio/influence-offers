class OfferClaimer < ApplicationService
  def self.call(player:, offer:)
    # Thin interface, but would be the place to put
    # any other logic that pertains to their claim
    # behavior.
    offer.save! if player.offers << offer
    response = Struct.new(:player, :offer)
    return response.new(player, offer)
  end
end