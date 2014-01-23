class Datapoint < ActiveRecord::Base
  belongs_to :goal
  validates :goal, presence: true
  validates :date, presence: true
end
