require 'spec_helper'

describe Datapoint do
  it { should belong_to(:goal) }
  it { should validate_presence_of(:goal) }
  it { should validate_presence_of(:date) }
end
