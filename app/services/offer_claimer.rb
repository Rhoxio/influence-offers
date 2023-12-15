class OfferClaimer < ApplicationService
  def self.call(player:, offer:)
    if player.offers << offer
      offer.increment(:total_claimed, by = 1)
      offer.save!
    end
    response = Struct.new(:player, :offer)
    return response.new(player, offer)
  end
end