class Datapoint < ActiveRecord::Base
  belongs_to :goal
  validates :goal, presence: true
end
