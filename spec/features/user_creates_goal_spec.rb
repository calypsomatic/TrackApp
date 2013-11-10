require 'spec_helper'

feature 'User creates a goal' do
	scenario 'User sees a form' do
		user = FactoryGirl.create(:user)
		visit root_path
		click_link 'Goals'
		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Sign in'
		click_link 'Create new goal'
		expect(page).to have_content('objective')
	end
end
