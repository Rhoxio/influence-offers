require 'rails_helper'

RSpec.describe Offer, type: :model do

  describe 'columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:target_age).of_type(:integer) }
    it { is_expected.to have_db_column(:max_age).of_type(:integer) }
    it { is_expected.to have_db_column(:min_age).of_type(:integer) }
  end  

  describe 'associations' do 
    it {should have_many(:target_genders)}
    it {should have_many(:claimed_offers)}
    it {should have_many(:players)}
    it {should have_many(:tags)}
  end

  describe 'validations' do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:target_age) }

    it { should validate_length_of(:title) }
    it { should validate_length_of(:description) }
    
    it { should validate_presence_of(:target_age) }
    it { should validate_numericality_of(:target_age) }

    it { should validate_presence_of(:max_age) }
    it { should validate_numericality_of(:max_age) }

    it { should validate_presence_of(:min_age) }
    it { should validate_numericality_of(:min_age) }

    before(:each) do 
      @offer = FactoryBot.build(:new_offer)
    end 

    context "target_age" do 
      it "should be valid if in range" do 
        (@offer.min_age..@offer.max_age).to_a.each do |age|
          @offer.target_age = age
          expect(@offer.valid?).to eq(true)
        end
      end

      it "should error if not in between min_age and max_age" do 
        @offer.target_age = @offer.max_age + 1
        expect{@offer.save!}.to raise_error(ActiveRecord::RecordInvalid)
        @offer.target_age = @offer.min_age - 1
        expect{@offer.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "should error if out of range" do
        @offer.target_age = Offer::AGE_BOUNDS.min - 1
        expect(@offer.valid?).to eq(false)
        expect{@offer.save!}.to raise_error(ActiveRecord::RecordInvalid)

        @offer.target_age = Offer::AGE_BOUNDS.max + 1
        expect(@offer.valid?).to eq(false)
        expect{@offer.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#total_claimed' do
    it "should provide the correct value" do 
      offer = FactoryBot.create(:new_offer)
      player = FactoryBot.create(:new_player)
      OfferClaimer.call(player: player, offer: offer)
      expect(offer.total_claimed).to eq(1)
    end
  end

  describe "defaults" do
    before(:each) do 
      @offer = FactoryBot.build(:new_offer)
    end

    it "on total_claimed should be 0" do 
      expect(FactoryBot.create(:new_offer).total_claimed).to eq(0)
    end    
  end

  describe "scopes" do 
    # Base age gen from factories is 35 with (30 min & 40 max)
    before(:all) do 
      4.times do 
        FactoryBot.create(:new_offer)
      end   

      4.times do 
        FactoryBot.create(:male_offer)
      end         
    end
  end
end