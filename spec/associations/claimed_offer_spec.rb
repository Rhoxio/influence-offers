require 'rails_helper'

RSpec.describe ClaimedOffer, type: :model do
  describe 'columns' do 
    it { is_expected.to have_db_column(:player_id).of_type(:integer) }
    it { is_expected.to have_db_column(:offer_id).of_type(:integer) }
  end

  describe 'linkages' do 
    context 'player' do 
      it "should be able to associate with Offers" do 
        @player = FactoryBot.create(:new_player)
        @offer = FactoryBot.create(:new_offer)

        # I want it to throw duplication errors! This is good.
        @offer.players << @player
        ap @offer.players
        @player.offers << @offer
        ap @player.offers
      end
    end
  end
end