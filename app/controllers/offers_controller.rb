class OffersController < ApplicationController
  before_action :authenticate_player!

  def discover
    suggestions = SuggestionGenerator.new(current_player).suggestions
    @offers = OffersFormatter.from_suggestions(suggestions)
    @player = current_player
    @tags = Tag.all
  end

  def claimed
    @player = current_player
    @claimed_offers = OffersFormatter.from_base(@player.offers)
    @tags = Tag.all
  end
end