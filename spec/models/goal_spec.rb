require 'spec_helper'

describe Goal do 
	it { should belong_to(:user) }
	it { should have_many(:datapoints) }
	it { should validate_numericality_of(:weekly_quantity) }
	it { should validate_numericality_of(:weekly_frequency) }
	it "is not valid with both quantity and frequency" do
		goal = FactoryGirl.build(:goal)
		goal.weekly_quantity = 60
		goal.weekly_frequency = 5
		expect(goal).to_not be_valid
	end
	it "is valid with either quantity xor frequency" do
		goal = FactoryGirl.build(:goal)
		expect(goal).to be_valid
	end
	it "calculates last week of datapoints" do
		goal = FactoryGirl.create(:goal) #default is weekly_frequency: 5
		datapoint = FactoryGirl.create(:datapoint, goal: goal, date: Date.today, amount: 1)
		datapoint2 = FactoryGirl.create(:datapoint, goal: goal, date: Date.yesterday, amount: 1)
		expect(goal.last_week_of_data).to eq(2)
	end
	it 'returns false if goal value not met' do
		goal = FactoryGirl.create(:goal)
		expect(goal.met_this_week?).to be_false
	end
	it 'returns true is goal value was met' do
		goal = FactoryGirl.create(:goal)
		datapoint = FactoryGirl.create(:datapoint, goal: goal, date: Date.today, amount: 2)
		datapoint2 = FactoryGirl.create(:datapoint, goal: goal, date: Date.yesterday, amount: 3)
		expect(goal.met_this_week?).to be_true
	end

	#it should have a table of data points
	#this could be a calendar

end