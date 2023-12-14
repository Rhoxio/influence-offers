class OffersController < ApplicationController
  before_action :authenticate_player!

  def discover
    @offers = Offer.preload(:tags).first(10).map {|offer| {offer: offer, tags: offer.tags}}
    @tags = Tag.all
  end

  def claimed
  end
end