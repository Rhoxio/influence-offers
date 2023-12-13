class OffersController < ApplicationController
  before_action :authenticate_player!

  def discover
    @offers = Offer.first(10)
  end

  def claimed
  end
end