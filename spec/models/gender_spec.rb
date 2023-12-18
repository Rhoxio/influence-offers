require 'rails_helper'

RSpec.describe Gender, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'associations' do 
    it {should have_many(:offers)}
  end  

  describe 'validations' do 
    it { should validate_presence_of(:name) }

    before(:each) do 
      @gender = Gender.create(name: "female", label: "Female")
    end

    context "name" do 
      it "should error out if not in whitelist" do
        @gender.name = "none"
        expect(@gender.valid?).to eq(false)
        expect{@gender.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "should save if present in the whitelist" do
        Gender::GENDERS.each do |gender|
          @gender.name = gender
          expect(@gender.valid?).to eq(true)
          expect(@gender.save!).to eq(true)          
        end        
      end   
    end

    context "label" do 
      it "should error out if not in whitelist" do
        @gender.label = "famle"
        expect(@gender.valid?).to eq(false)
        expect{@gender.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "should save if present in the whitelist" do
        Gender::LABELS.each do |label|
          @gender.label = label
          expect(@gender.valid?).to eq(true)
          expect(@gender.save!).to eq(true)          
        end        
      end   
    end 

  end
end