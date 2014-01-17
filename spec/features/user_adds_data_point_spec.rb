require 'spec_helper'
include Warden::Test::Helpers

feature 'User adds a data point' do

  scenario 'User chooses goal to add to' do
    user = FactoryGirl.create(:user)
    Warden.test_mode!
    login_as(user, scope: :user)
    goal = FactoryGirl.create(:goal, user: user)
    visit goal_path(goal)
    expect(page).to have_content("Add data")
  end

  scenario 'User creates data attached to goal' do
    user = FactoryGirl.create(:user)
    Warden.test_mode!
    login_as(user, scope: :user)
    goal = FactoryGirl.create(:goal, user: user)
    visit goal_path(goal)
    click_link "Add data"
    fill_in 'Amount', with: 5
    click_button 'Create Datapoint'
    expect(page).to have_content("successfully created")
    #how do i get the datapoint?
    #expect(datapoint.goal_id).to eq(goal.id)
  end

end