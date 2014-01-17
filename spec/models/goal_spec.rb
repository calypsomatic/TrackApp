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

	#it should have a table of data points
	#this could be a calendar
	#then create feature spec user enters data point

end