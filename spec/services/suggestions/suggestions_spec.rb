require 'rails_helper'

RSpec.describe "suggestions system" do

  before(:all) do 
    @player = FactoryBot.create(:new_player)
    7.times {FactoryBot.create(:tag)}
    @tags = Tag.all
    @offers = []

    25.times do 
      offer = FactoryBot.create(:random_offer)
      # offer.min_age = (offer.target_age - 5)
      # offer.max_age = (offer.target_age + 5)
      offer.tags << @tags.shuffle.take(3)
      @offers.push(offer)
    end

    appliable_offers = @offers.take(10)
    appliable_offers.each do |offer|
      results = OfferClaimer.call(player: @player, offer: offer)
    end
    
  end

  it "will sandbox" do 
    # ap @player.offers
    # ap @offers
    # ap @player.claimed_offers
    gen = SuggestionGenerator.new(@player)
    # ap gen.tag_frequencies
    # ap gen.min_max_tag_frequencies
    # ap gen.offers_by_player_gender
    # ap gen.offers_outside_of_player_gender
    # ap gen.weight_struct
    # ap gen.relevant_offers
    # ap gen.claimed_offers
    # gen.weigh_age_range
    # gen.weigh_gender
    # ap @player
    # ap gen.offer_weights

    # gen.weigh_tags
    
    gen.generate_weights
    ap gen.offer_weights
  end

end