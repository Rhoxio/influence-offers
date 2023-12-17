require 'rails_helper'

RSpec.describe "offer_claimer service" do
  before(:each) do 
    @player = FactoryBot.create(:new_player)
    @offer = FactoryBot.create(:new_offer)
  end

  it "will claim an offer" do 
    result = OfferClaimer.call(player: @player, offer: @offer)
    expect(@offer.total_claimed > 0).to eq(true)
    expect(@player.offers.include?(@offer)).to eq(true)
    expect(@offer.players.include?(@player)).to eq(true)
  end

  it "will not claim duplicate offers" do 
    OfferClaimer.call(player: @player, offer: @offer)
    expect{OfferClaimer.call(player: @player, offer: @offer)}.to raise_error(ActiveRecord::RecordNotUnique)
  end


  it "will hold the correct count" do
    players = [FactoryBot.create(:new_player), FactoryBot.create(:new_player), FactoryBot.create(:new_player)]
    results = []
    players.each do |player|
      results << OfferClaimer.call(player: player, offer: @offer)
    end
    expect(results.last.offer.total_claimed).to eq(3)
  end


end