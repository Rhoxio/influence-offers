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

    it "will weigh tags evenly" do 
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

  describe "age weight" do 
    before(:all) do 
      Offer.destroy_all
      Tag.destroy_all

      @player = FactoryBot.create(:new_player)
      7.times {FactoryBot.create(:tag)}
      @tags = Tag.all
      @offers = [
        Offer.create!(title: "Offer", description: "An Offer", max_age: 45, min_age: 25, target_age: 35, target_gender: "female"),
        Offer.create!(title: "Offer", description: "An Offer", max_age: 45, min_age: 25, target_age: 36, target_gender: "female"),
        Offer.create!(title: "Offer", description: "An Offer", max_age: 45, min_age: 25, target_age: 33, target_gender: "female"),
        Offer.create!(title: "Offer", description: "An Offer", max_age: 45, min_age: 25, target_age: 29, target_gender: "female"),
        Offer.create!(title: "Offer", description: "An Offer", max_age: 45, min_age: 25, target_age: 40, target_gender: "female"),
        Offer.create!(title: "Offer", description: "An Offer", max_age: 45, min_age: 25, target_age: 43, target_gender: "female")
      ]

      @offers.each do |offer|
        offer.tags << @tags.shuffle.take(3)
      end

    end

    it "will generate age weights" do 
      gen = SuggestionGenerator.new(@player)
      gen.offer_weights do |weight_set|
        expect(weight_set.contribution[:age] > 0).to eq(true)
      end
    end

    it "will assign 10 to exact matches" do 
      gen = SuggestionGenerator.new(@player)
      gen.offer_weights do |weight_set|
        if (offer.target_age == @player.age)
          expect(weight_set.contribution[:age]).to eq(10)
        end
      end      
    end

    it "will assign differences for different ratios" do 
      gen = SuggestionGenerator.new(@player)
      # Just one max away - should round to 9 since not exact
      expect(gen.offer_weights[1].contribution[:age]).to eq(9)

      # Over 1/10 away from mid on min (-2), should assign 8 after round
      expect(gen.offer_weights[2].contribution[:age]).to eq(8)

      # Farther away at almost half - Should round to 6 on min
      expect(gen.offer_weights[3].contribution[:age]).to eq(6)

      # 5 away, rounds to 6 after ratio on max
      expect(gen.offer_weights[4].contribution[:age]).to eq(6)

      # 8 away, rounds to 5 after matio at max
      expect(gen.offer_weights[5].contribution[:age]).to eq(5)
    end

  end

end