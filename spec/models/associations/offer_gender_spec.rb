require 'rails_helper'

RSpec.describe OfferGender, type: :model do
  describe 'columns' do 
    it { is_expected.to have_db_column(:gender_id).of_type(:integer) }
    it { is_expected.to have_db_column(:offer_id).of_type(:integer) }
  end

  describe 'associations' do 
    it { should belong_to(:gender) }
    it { should belong_to(:offer) }
  end
  
end