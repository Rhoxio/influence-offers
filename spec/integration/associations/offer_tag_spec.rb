require 'rails_helper'

RSpec.describe "Offer and Tag Relationships" do
  describe 'linkages' do 

    before(:each) do 
      @offer = FactoryBot.create(:new_offer)
      @tag = FactoryBot.create(:tag)
    end

    context 'offer' do 
      it 'should be able to associate with Tags' do 
        @offer.tags << @tag
        expect(@offer.tags.length > 0).to eq(true)
        expect(@offer.tags.first).to eq(@tag)
      end

      it 'will not allow for duplicate tags to be associated' do 
        @offer.tags << @tag
        expect{@offer.tags << @tag}.to raise_error(ActiveRecord::RecordNotUnique)
      end

      it "will allow for multiple tags to be associated" do 
        new_tag = FactoryBot.create(:tag)
        @offer.tags << [@tag, new_tag]
        expect(@offer.tags.length).to eq(2)
      end

      it "will destroy the join row if Offer is destroyed" do 
        @offer.tags << @tag
        @offer.destroy
        expect(@tag.offers.length).to eq(0)
      end
    end

    context 'tag' do 
      it 'should be able to associate with Offers' do 
        @tag.offers << @offer
        expect(@tag.offers.length > 0).to eq(true)
        expect(@tag.offers.first).to eq(@offer)
      end

      it 'will not allow for duplicate Offers to be associated' do 
        @tag.offers << @offer
        expect{@tag.offers << @offer}.to raise_error(ActiveRecord::RecordNotUnique)
      end

      it "will allow for multiple Offers to be associated" do 
        new_offer = FactoryBot.create(:new_offer)
        @tag.offers << [@offer, new_offer]
        expect(@tag.offers.length).to eq(2)
      end

      it "will destroy the join row if Tag is destroyed" do 
        @tag.offers << @offer
        @tag.destroy
        expect(@offer.tags.length).to eq(0)
      end
    end

  end
end