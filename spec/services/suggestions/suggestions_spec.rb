require 'rails_helper'

RSpec.describe "suggestions system" do

  # before(:all) do 
  #   Offer.destroy_all
  #   Tag.destroy_all  
  # end

  describe "tag_weights" do 
    before(:all) do 
      Offer.destroy_all
      Tag.destroy_all

      @player = FactoryBot.create(:new_player)
      7.times {FactoryBot.create(:tag)}
      @tags = Tag.all
      @offers = []

      # Creating differences...
      3.times do 
        # First 3 tags
        offer = FactoryBot.create(:new_offer)
        offer.tags << @tags.first(3)
        @offers.push(offer)
      end

      3.times do 
        # Last 3 tags
        offer = FactoryBot.create(:new_offer)
        offer.tags << @tags.last(3)
        @offers.push(offer)
      end

      # Creating similarities
      4.times do
        offer = FactoryBot.create(:new_offer)
        offer.tags << @tags[2..5]
        # Claiming the similar offers...
        OfferClaimer.call(player: @player, offer: offer)
        @offers.push(offer)
      end
    end

    it "will generate an applicable weight" do 
      gen = SuggestionGenerator.new(@player)
      first_tag_weight = gen.offer_weights.first.contribution[:tags]
      last_tag_weight = gen.offer_weights.last.contribution[:tags]
      expect(first_tag_weight).to eq(2)
      expect(last_tag_weight).to eq(1)
      expect(first_tag_weight > last_tag_weight).to eq(true)
    end

    it "will increase weight if more matching tags exist" do 
      4.times do
        offer = FactoryBot.create(:new_offer)
        offer.tags << @tags.first(3)
        # Claiming the similar offers...
        OfferClaimer.call(player: @player, offer: offer)
      end
      # Have to call gen again because new stuff was added...
      gen = SuggestionGenerator.new(@player)

      first_tag_weight = gen.offer_weights.first.contribution[:tags]
      last_tag_weight = gen.offer_weights.last.contribution[:tags]
      expect(first_tag_weight > 2).to eq(true)
      expect(last_tag_weight > 1).to eq(true)
    end

    it "will have 0 weight if no matching tags exist" do 
      @player = FactoryBot.create(:new_player)
      gen = SuggestionGenerator.new(@player)
      gen.offer_weights.each do |weight_data|
        expect(weight_data.contribution[:tags]).to eq(0)
      end
    end

    it "will weigh them evenly" do 
      # Putting them all in - should / length and give 0 since they all match
      @offers.each do |offer|
        offer.tags = []
        offer.tags << @tags
      end
      @player.offers = []
      OfferClaimer.call(player: @player, offer: @offers.first)
      gen = SuggestionGenerator.new(@player)
      tag_weights = gen.offer_weights.map{|weights| weights.contribution[:tags]}.uniq
      expect(tag_weights.length).to eq(1)
    end

  end

  describe "total_claimed weight" do 
    before(:all) do 
      Offer.destroy_all
      Tag.destroy_all

      @player = FactoryBot.create(:new_player)
      @second_player = FactoryBot.create(:new_player)

      7.times {FactoryBot.create(:tag)}
      @tags = Tag.all
      @offers = []

      10.times do 
        offer = FactoryBot.create(:new_offer)
        offer.tags << @tags.first(3)
        @offers.push(offer)        
      end

      @offers.first(3).each do |offer|
        OfferClaimer.call(player: @second_player, offer: offer)
      end

    end

    it "will provide the correct contributions" do
      gen = SuggestionGenerator.new(@player)
      claimed_weights = gen.offer_weights.map do |weight_set|
        weight_set.contribution[:claimed]
      end
      expect(claimed_weights.count(1)).to eq(3)
      expect(claimed_weights.count(0)).to eq(7)
    end
  end

  describe "gender weight" do 
    before(:all) do 
      Offer.destroy_all
      Tag.destroy_all

      @player = FactoryBot.create(:new_player)
      7.times {FactoryBot.create(:tag)}
      @tags = Tag.all
      @offers = []

      9.times do 
        offer = FactoryBot.create(:new_offer)
        offer.tags << @tags.first(3)
        @offers.push(offer)     
      end

      offer = FactoryBot.create(:new_offer)
      offer.target_gender = "male"
      offer.save
      offer.tags << @tags.first(3)
      @offers.push(offer)

    end    

    it "will weigh if female" do 
      gen = SuggestionGenerator.new(@player)
      gender_weights = gen.offer_weights.map do |weight_set|
        weight_set.contribution[:gender]
      end   
      expect(gender_weights.count(10)).to eq(9)
      expect(gender_weights.count(0)).to eq(1)    
    end

    it "will weigh if male" do 
      @player.gender = "male"
      @player.save
      gen = SuggestionGenerator.new(@player)
      gender_weights = gen.offer_weights.map do |weight_set|
        weight_set.contribution[:gender]
      end
      expect(gender_weights.count(0 )).to eq(9)
      expect(gender_weights.count(10)).to eq(1)
    end

    it "will not weigh if non-binary" do 
      @player = FactoryBot.create(:new_player)
      @player.gender = "nonbinary"
      @player.save
      gen = SuggestionGenerator.new(@player)
      gender_weights = gen.offer_weights.map do |weight_set|
        weight_set.contribution[:gender]
      end   
      expect(gender_weights.count(0)).to eq(10)
    end

    it "will not weigh if declined" do 
      @player = FactoryBot.create(:new_player)
      @player.gender = "declined"
      @player.save
      gen = SuggestionGenerator.new(@player)
      gender_weights = gen.offer_weights.map do |weight_set|
        weight_set.contribution[:gender]
      end   
      expect(gender_weights.count(0)).to eq(10)
    end    

  end

  # it "will sandbox" do 
  #   # ap @player.offers
  #   # ap @offers
  #   # ap @player.claimed_offers
  #   gen = SuggestionGenerator.new(@player)
  #   # ap gen.tag_frequencies
  #   # ap gen.min_max_tag_frequencies
  #   # ap gen.offers_by_player_gender
  #   # ap gen.offers_outside_of_player_gender
  #   # ap gen.weight_struct
  #   # ap gen.relevant_offers
  #   # ap gen.claimed_offers
  #   # gen.weigh_age_range
  #   # gen.weigh_gender
  #   # ap @player
  #   # ap gen.offer_weights

  #   # gen.weigh_tags
    
  #   gen.generate_weights
  #   ap gen.offer_weights
  # end

end