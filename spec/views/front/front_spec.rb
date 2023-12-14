require 'rails_helper'

RSpec.describe "front page", type: :feature do 
  before(:each) do
    visit "/"
  end

  context "elements" do 
    it "will render the header" do 
      expect(page).to have_content 'Influence Offers'
    end    
  end  

  context "auth" do
    it "will render session buttons" do 
      expect(page).to have_button("SIGN IN")
      expect(page).to have_button("SIGN UP")
    end    
  end

end