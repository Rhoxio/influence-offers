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

  describe "before_validation" do 

    before(:each) do 
      # If no min_age or max_age - should call #assign_default_max_and_min on validation
      @offer = Offer.new(title: "Incomplete Offer", description:"Incomplete", target_age: 30)
    end

    context "ranges" do 
      it "will assign a default max_age" do 
        @offer.save
        expect(@offer.max_age).to eq(@offer.target_age + 1)
      end

      it "will assign a default min_age" do 
        @offer.save
        expect(@offer.min_age).to eq(@offer.target_age - 1)        
      end  

      context 'defaults with #assign_default_max_and_min' do 
        it "will not assign max_age if out of range" do 
          @offer.target_age = 125
          expect{@offer.save!}.to raise_error(ActiveRecord::RecordInvalid)
        end  

        it "will not assign min_age if out of range" do 
          @offer.target_age = 1
          expect{@offer.save!}.to raise_error(ActiveRecord::RecordInvalid)
        end           
      end
     
    end 
  end  

  describe 'validations' do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:target_age) }

    it { should validate_length_of(:title) }
    it { should validate_length_of(:description) }
    
    it { should validate_numericality_of(:target_age) }
    it { should validate_numericality_of(:max_age) }
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

end