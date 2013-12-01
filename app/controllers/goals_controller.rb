class GoalsController < ApplicationController
	before_filter :authenticate_user!


	def index
		@goals = current_user.goals
	end

	def new
		@goal = Goal.new
	end

	def create
		@goal = current_user.goals.new(goals_params)
		if @goal.save
			flash[:notice] = "Goal created"
			redirect_to @goal
		else
			render "new"
		end
	end

	def show
		@goal = current_user.goals.find(goal_params[:id])
	end

	private

	def goals_params
		params.require(:goal).permit(:objective, :weekly_frequency, :weekly_quantity)
	end

	def goal_params
		params.permit(:id)
	end
end
