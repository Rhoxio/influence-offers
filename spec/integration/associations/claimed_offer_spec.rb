require 'rails_helper'

RSpec.describe "Offer and Player Relationships" do

  describe 'linkages' do 
    before(:each) do 
      @player = FactoryBot.create(:new_player)
      @offer = FactoryBot.create(:new_offer)      
    end

    context 'offer' do 
      it "should be able to associate with Offers" do 
        @offer.players << @player
        expect(@offer.players.length > 0).to eq(true)
        expect(@offer.players.first).to eq(@player)
      end

      it "will not allow for duplicate players to be associated" do 
        @offer.players << @player
        expect{@offer.players << @player}.to raise_error(ActiveRecord::RecordNotUnique)
      end

      it "will allow for multiple players to be associated" do 
        @new_player = FactoryBot.create(:new_player)
        @offer.players << [@player, @new_player]
        expect(@offer.players.length).to eq(2)
      end

      it "will destroy the join row if Player is destroyed" do
        @offer.players << @player
        @offer.destroy
        expect(@player.offers.length).to eq(0)
      end
    end

    context 'player' do 
      it "should be able to associate with Offers" do 
        @player.offers << @offer
        expect(@player.offers.length > 0).to eq(true)
        expect(@player.offers.first).to eq(@offer)
      end

      it "will not allow for duplicate offers to be associated" do 
        @player.offers << @offer
        expect{@player.offers << @offer}.to raise_error(ActiveRecord::RecordNotUnique)
      end   

      it "will allow for multiple offers to be associated" do 
        @new_offer = FactoryBot.create(:new_offer)
        @player.offers << [@offer, @new_offer]
        expect(@player.offers.length).to eq(2)
      end 

      it "will destroy the join row if Offer is destroyed" do
        @player.offers << @offer
        @player.destroy
        expect(@player.offers.length).to eq(0)
      end              
    end    
  end
end