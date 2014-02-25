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
	validates :weight, numericality: true, allow_blank: false
	validates_with EitherWeekly

	def last_week_of_data
		last_week = Date.today - 7
		recent_data = self.datapoints.where(date: last_week..Date.today)
		total_this_week = 0
		recent_data.each do |point|
			total_this_week += point.amount
		end
		total_this_week
	end

	def met_this_week?
		if self.weekly_quantity.present?
			return self.last_week_of_data >= self.weekly_quantity
		else
			return self.last_week_of_data >= self.weekly_frequency
		end
	end

	def gap
		if self.weekly_quantity.present?
			return self.weekly_quantity - self.last_week_of_data
		else
			return self.weekly_frequency - self.last_week_of_data
		end
	end

	class << self
		def score (user)
			running_score = 0
			user.goals.each do |goal|
				running_score += goal.last_week_of_data*goal.weight
			end
			running_score
		end

		def target_score (user)
			target = 0
			user.goals.each do |goal|
				if goal.weekly_frequency.present?
        	target += goal.weekly_frequency*goal.weight
      	else
        	target += goal.weekly_quantity*goal.weight
      	end
			end
			target
		end
	end

end


