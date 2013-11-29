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

	scenario 'User sees goal is saved' do
		visit new_goal_path
		fill_in 'Objective', with: 'objective'
		fill_in 'Weekly frequency', with: '5'
		prev_goals = Goal.count
		click_button 'Create Goal'
		expect(page).to have_content('Goal created')
		expect(Goal.count).to be >(prev_goals)
	end

	scenario 'User sees goal' do
		goal = FactoryGirl.create(:goal, user: user)
		visit goals_path
		expect(page).to have_content(goal.objective)
		expect(page).to have_content(goal.weekly_frequency)
	end

	scenario 'User chooses between frequency and quantity' do
		visit new_goal_path
		fill_in 'Objective', with: 'objective'
		fill_in 'Weekly frequency', with: '5'
		fill_in 'Weekly quantity', with: '5'
		click_button 'Create Goal'
		expect(page).to have_content('cannot be set')
	end

end
