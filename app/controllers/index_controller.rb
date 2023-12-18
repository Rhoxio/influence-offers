class IndexController < ApplicationController
  def show
    redirect_to(discover_url) if player_signed_in?
  end
end
