require 'spec_helper'

describe Goal do 
	it { should belong_to(:user) }
	it { should have_many(:datapoints) }
	it { should validate_numericality_of(:weekly_quantity) }
	it { should validate_numericality_of(:weekly_frequency) }
	it { should validate_numericality_of(:weight) }
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
	it 'calculates current score' do
		user = FactoryGirl.create(:user)
		goal1 = FactoryGirl.create(:goal, user: user, weight: 2)
		goal2 = FactoryGirl.create(:goal, user: user)
		datapoint = FactoryGirl.create(:datapoint, goal: goal1, date: Date.today, amount: 1)
		datapoint2 = FactoryGirl.create(:datapoint, goal: goal2, date: Date.yesterday, amount: 1)
		datapoint3 = FactoryGirl.create(:datapoint, goal: goal2, date: Date.yesterday-8, amount: 1)
		expect(Goal.score(user)).to eq(3)
	end
	it 'calculates target score' do
		user = FactoryGirl.create(:user)
		goal1 = FactoryGirl.create(:goal, weekly_frequency: 7, user: user, weight: 2)
		goal2 = FactoryGirl.create(:goal, weekly_frequency: nil, weekly_quantity: 20, user: user)
		expect(Goal.target_score(user)).to eq(34)
	end
	it 'calculates gap between target and achieved' do
		user = FactoryGirl.create(:user)
		goal = FactoryGirl.create(:goal, user: user)
		datapoint = FactoryGirl.create(:datapoint, goal: goal, date: Date.today, amount: 2)
		expect(goal.gap).to eq(3)
	end

	#it should have a table of data points
	#this could be a calendar

end