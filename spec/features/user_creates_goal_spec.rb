require 'spec_helper'
include Warden::Test::Helpers

feature 'User creates a goal' do

	after :each do
		Warden.test_reset!
	end

	scenario 'User sees a form' do
		user = FactoryGirl.create(:user)
		visit root_path
		click_link 'Goals'
		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Sign in'
		click_link 'Create new goal'
		expect(page).to have_content('Objective')
	end
	scenario 'User sees new goal' do
		Warden.test_mode!
		user = FactoryGirl.create(:user)
		login_as(user, scope: :user)
		visit new_goal_path
		fill_in 'Objective', with: 'objective'
		prev_goals = Goal.count
		click_button 'Create Goal'
		expect(page).to have_content('Goal created')
		expect(Goal.count).to be >(prev_goals)
	end
end
