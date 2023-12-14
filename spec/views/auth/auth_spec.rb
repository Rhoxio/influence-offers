require 'rails_helper'

RSpec.describe "front page", type: :feature do 
  context "sign up" do 

    before(:each) do
      visit "/players/sign_up"
    end

    it "will create a player" do
      within('#new_player') do 
        fill_in 'Email', with: Faker::Internet.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        fill_in 'Age', with: 35
      end
      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    it "will fail if no email is supplied" do
      within('#new_player') do 
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        fill_in 'Age', with: 35
      end
      click_button 'Sign up'
      expect(page).to have_content "Email can't be blank"
    end     

    it "will fail if no password is supplied" do
      within('#new_player') do 
        fill_in 'Email', with: Faker::Internet.email
        fill_in 'Age', with: 35
      end
      click_button 'Sign up'
      expect(page).to have_content "Password can't be blank"
    end    

    it "will fail if no age is supplied" do
      within('#new_player') do 
        fill_in 'Email', with: Faker::Internet.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content "Age can't be blank"
    end

    it "will fail if age is out of range" do 
      within('#new_player') do 
        fill_in 'Age', with: 200
      end  
      click_button 'Sign up'  
      expect(page).to have_content 'Age must be in 1..125'  

      within('#new_player') do 
        fill_in 'Age', with: 0
      end     
      click_button 'Sign up'  
      expect(page).to have_content 'Age must be in 1..125'         
    end      
  end

end