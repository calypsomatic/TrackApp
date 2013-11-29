require 'spec_helper'
include Warden::Test::Helpers

feature 'User creates a goal' do

	let(:user) { FactoryGirl.create(:user) }
		
	before :each do
		Warden.test_mode!
		login_as(user, scope: :user)
	end

	after :each do
		Warden.test_reset!
	end

	scenario 'User sees a form' do
		visit root_path
		click_link 'Goals'
		click_link 'Create new goal'
		expect(page).to have_content('Objective')
	end
	
	scenario 'User sees new goal' do
		visit new_goal_path
		fill_in 'Objective', with: 'objective'
		prev_goals = Goal.count
		click_button 'Create Goal'
		expect(page).to have_content('Goal created')
		expect(Goal.count).to be >(prev_goals)
	end
end
