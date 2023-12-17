require 'rails_helper'

RSpec.describe ApplicationApiController do

  describe "modules" do 
    it "contains the ApiErrorHandling module" do
      expect(ApplicationApiController.include?(ApiErrorHandling)).to eq(true)
    end
  end   

  describe 'constant dependencies' do 
    it "loads the $API_ERRORS global" do 
      expect(!!$API_ERRORS).to eq(true)
    end
  end  
end