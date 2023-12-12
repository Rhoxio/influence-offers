require 'rails_helper'

RSpec.describe Player, type: :model do

  describe 'columns' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:age).of_type(:integer) }
    it { is_expected.to have_db_column(:gender).of_type(:string) }
  end

  describe 'associations' do 
    it {should have_many(:claimed_offers)}
  end

  describe 'validations' do 
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:gender) }

    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }

    context "whitelisting" do 

      before(:each) do 
        @player = FactoryBot.build(:new_player)
      end    

      context "gender" do

        it "should error out if not in whitelist" do
          @player.gender = "none"
          expect(@player.valid?).to eq(false)
          expect{@player.save!}.to raise_error(ActiveRecord::RecordInvalid)
        end

        it "should save if present in the whitelist" do
          Player::GENDERS.each do |gender|
            @player.gender = gender
            expect(@player.valid?).to eq(true)
            expect(@player.save!).to eq(true)          
          end        
        end 

      end

      context "age" do 

        it "should error out if out of range" do
          @player.age = Player::AGE_RANGE.min - 1
          expect(@player.valid?).to eq(false)
          expect{@player.save!}. to raise_error(ActiveRecord::RecordInvalid)

          @player.age = Player::AGE_RANGE.max + 1
          expect(@player.valid?).to eq(false)
          expect{@player.save!}. to raise_error(ActiveRecord::RecordInvalid)
        end

        it "should be valid if in range" do
          Player::AGE_RANGE.to_a.each do |age|
            @player.age = age
            expect(@player.valid?).to eq(true)
          end
        end

      end


    end


  end
end
