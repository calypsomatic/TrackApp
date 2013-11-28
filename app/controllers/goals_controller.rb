class GoalsController < ApplicationController
	before_filter :authenticate_user!


	def index
		#@goals = current_user.goals
	end

	def new
		@goal = Goal.new
	end

	def create
		@goal = current_user.goals.new(goals_params)
		if @goal.save
			flash[:notice] = "Goal created"
			redirect_to action: :index
		else
			render "new"
		end
	end

	private

	def goals_params
		params.require(:goal).permit(:objective)
	end
end
