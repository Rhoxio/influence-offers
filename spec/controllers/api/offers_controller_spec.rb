require 'rails_helper'

RSpec.describe Api::V1::OffersController, type: :request do

  before(:each) do
    @offer = FactoryBot.create(:new_offer)
    @player = FactoryBot.create(:new_player)

    Warden.test_mode!
    login_as(@player, scope: :player)

    @headers = { "Content-Type" => "application/json" }
    allow(Api::V1::OffersController).to receive(:protect_from_forgery).and_return(false)
  end

  after(:each) do 
    Warden.test_reset!
  end

  it "will claim an offer" do 
    post(api_v1_offer_claim_url(@offer.id), headers: @headers)
    res = JSON.parse(response.body)
    expect(res["player"]["id"]).to eq(@player.id)
    expect(res["offer"]["id"]).to eq(@offer.id)

    @offer.reload
    expect(@offer.total_claimed > 0).to eq(true)
    expect(@player.offers.include?(@offer)).to eq(true)
  end

  context "error cases" do
    it "will 409 on duplicate offer claim" do 
      post(api_v1_offer_claim_url(@offer.id), headers: @headers)
      post(api_v1_offer_claim_url(@offer.id), headers: @headers)
      res = JSON.parse(response.body)
      expect(response.status).to eq(409)
      expect(res['title']).to eq('Conflict')
    end

    it "will 401 on no session" do 
      logout(:player)
      post(api_v1_offer_claim_url(@offer.id), headers: @headers)
      res = JSON.parse(response.body)
      expect(response.status).to eq(401)
      expect(res['title']).to eq('Unauthorized')
    end

    it "will 400 on invalid offer id" do 
      post(api_v1_offer_claim_url(9999999999), headers: @headers)
      res = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(res['title']).to eq('Not Found')
    end
  end


end