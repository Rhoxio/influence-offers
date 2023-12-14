class OffersController < ApplicationController
  before_action :authenticate_player!

  def discover
    @offers = Offer.first(10)
    @tags = Tag.all
  end

  def claimed
  end
end