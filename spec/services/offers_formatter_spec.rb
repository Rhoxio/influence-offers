require 'rails_helper'

RSpec.describe "OffersFormatter" do

  before(:all) do 
    @offers = []
    3.times {FactoryBot.create(:tag)}
    3.times do
      @offers << FactoryBot.create(:new_offer)
    end
    @offers.each do |offer|
      offer.tags << Tag.first(3).sample
    end
  end

  it "will format from_base" do 
    formatted_hash = OffersFormatter.from_base(@offers)
    @offers.each_with_index do |offer, index|
      expect(formatted_hash[index][:offer]).to eq(offer)
      expect(formatted_hash[index][:tags].is_a?(Array)).to eq(true)
      expect(formatted_hash[index][:show]).to eq(true)
    end
  end

  describe "from_suggestions" do 
    it "will format" do 
      @player = FactoryBot.create(:new_player)
      gen = SuggestionGenerator.new(@player)
      formatted_hash = OffersFormatter.from_suggestions(gen.offer_weights)
    end

    it "will error out with bad args" do
      # skipping weight
      expect{OffersFormatter.from_suggestions({offer: @offers.first, contribution: {}})}.to raise_error(ArgumentError)
      # skipping contribution
      expect{OffersFormatter.from_suggestions({offer: @offers.first, weight: 0})}.to raise_error(ArgumentError)
      # skipping offer
      expect{OffersFormatter.from_suggestions({weight: 0, contribution: {}})}.to raise_error(ArgumentError)
    end
  end

end