class OffersController < ApplicationController
  before_action :authenticate_player!

  def discover
    if current_player.offers.length == 0
      @offers = OffersFormatter.from_base(Offer.preload(:tags).first(100))
    else
      suggestions = SuggestionGenerator.new(current_player).suggestions
      @offers = OffersFormatter.from_suggestions(suggestions)
    end
    @player = current_player
    @tags = Tag.all
  end

  def claimed
    @player = current_player
    @claimed_offers = OffersFormatter.from_base(@player.offers)
    @tags = Tag.all
  end
end