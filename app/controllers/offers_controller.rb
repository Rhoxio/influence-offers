class OffersController < ApplicationController
  before_action :authenticate_player!

  def discover
    @offers = Offer.preload(:tags).first(100).map {|offer| {offer: offer, tags: offer.tags.sort_by(&:name), show: true}}
    @tags = Tag.all
  end

  def claimed
    @player = current_player
    @claimed_offers = @player.offers
  end
end