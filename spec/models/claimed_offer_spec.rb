require 'rails_helper'

RSpec.describe ClaimedOffer, type: :model do
  describe 'columns' do 
    it { is_expected.to have_db_column(:player_id).of_type(:integer) }
    it { is_expected.to have_db_column(:offer_id).of_type(:integer) }
  end
end