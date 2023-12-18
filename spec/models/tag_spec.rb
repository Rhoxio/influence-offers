require 'rails_helper'

RSpec.describe Tag, type: :model do

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:slug).of_type(:string) }
  end

  describe "validations" do 
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "defaults" do
    it "will #generate_slug before saving" do
      tag = Tag.create(name: "Cool Tag")
      expect(tag.slug).to eq("cool_tag")
    end
  end
end
