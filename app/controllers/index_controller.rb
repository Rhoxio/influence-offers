class IndexController < ApplicationController
  def show
    redirect_to(discover_url) if player_signed_in?
    # flash[:alert] = "Something is wrong!"
    # flash[:notice] = "Notice me!"
  end
end
