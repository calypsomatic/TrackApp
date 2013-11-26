class GoalsController < ApplicationController
	before_filter :authenticate_user!


	def index
		#@goals = current_user.goals
	end

	def new
		@goal = Goal.new
	end
end
