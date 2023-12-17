require 'rails_helper'

RSpec.describe Api::V1::SuggestionsController, type: :request do

  before(:each) do
    5.times {FactoryBot.create(:new_offer)}
    @player = FactoryBot.create(:new_player)

    Warden.test_mode!
    login_as(@player, scope: :player)

    @headers = { "Content-Type" => "application/json" }
    allow(Api::V1::OffersController).to receive(:protect_from_forgery).and_return(false)    
  end

  after(:each) do 
    Warden.test_reset!
  end


  describe "#suggest" do 
    it "will retrieve suggestions" do 
      get(api_v1_player_offers_suggestions_url({player_id: @player.id}), headers: @headers)
      res = JSON.parse(response.body)
      expect(res.length > 0).to eq(true)
      expect(res[0].key?('offer')).to eq(true)
    end

    it "will error out if bad player_id is supplied" do 
      get(api_v1_player_offers_suggestions_url({player_id: 999999999}), headers: @headers)
      expect(response.status).to eq(400)
    end

    it "will 401 on no session" do 
      logout(:player)
      get(api_v1_player_offers_suggestions_url({player_id: @player.id}), headers: @headers)
      expect(response.status).to eq(401)
    end
  end

end