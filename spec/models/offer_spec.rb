require 'rails_helper'

RSpec.describe Offer, type: :model do

  describe 'columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:target_age).of_type(:integer) }
    it { is_expected.to have_db_column(:target_gender).of_type(:string) }
    it { is_expected.to have_db_column(:max_age).of_type(:integer) }
    it { is_expected.to have_db_column(:min_age).of_type(:integer) }
    it { is_expected.to have_db_column(:total_claimed).of_type(:integer) }

    # test target_gender
  end  

  describe 'associations' do 
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

    context "target_gender" do

      it "should error out if not in whitelist" do
        @offer.target_gender = "none"
        expect(@offer.valid?).to eq(false)
        expect{@offer.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "should save if present in the whitelist" do
        Offer::GENDERS.each do |target_gender|
          @offer.target_gender = target_gender
          expect(@offer.valid?).to eq(true)
          expect(@offer.save!).to eq(true)          
        end        
      end 

    end    

    context "target_age" do 
      it "should be valid if in range" do 
        Offer::AGE_BOUNDS.to_a.each do |age|
          @offer.target_age = age
          expect(@offer.valid?).to eq(true)
        end
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

    context '#in_age_range' do 
      it "will pull by age range" do 
        offers = Offer.in_age_range(35)
        offers.each do |offer|
          expect(offer.min_age < 35).to eq(true)
          expect(offer.max_age > 35).to eq(true)
        end
      end
    end

    context '#targeting' do 
      it '#targeting will pull by gender' do 
        female_offers = Offer.targeting("female")
        expect(female_offers.length >= 4).to eq(true)
      end

      it '#targeting will pull by gender' do 
        other_offers = Offer.not_targeting("female")
        other_offers.each do |offer|
          expect(offer.target_gender).to_not eq("female")  
        end
      end  
    end 

    context 'combinatory' do 
      it "will pull by age range and gender when chained" do 
        offers = Offer.targeting("female").in_age_range(35)
        offers.each do |offer|
          expect(offer.min_age < 35).to eq(true)
          expect(offer.max_age > 35).to eq(true)
          expect(offer.target_gender).to eq("female")
        end
      end
    end

  end

end