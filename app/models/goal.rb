class EitherWeekly < ActiveModel::Validator
	def validate(goal)
		if goal.weekly_quantity.present? && goal.weekly_frequency.present?
			goal.errors[:weekly_frequency] << "cannot be set if weekly_quantity is set"
			goal.errors[:weekly_quantity] << "cannot be set if weekly_frequency is set"
		end
	end
end

class Goal < ActiveRecord::Base
	belongs_to :user, inverse_of: :goals
	has_many :datapoints
	validates :weekly_frequency, numericality: true, allow_blank: true
	validates :weekly_quantity, numericality: true, allow_blank: true
	validates_with EitherWeekly
end


