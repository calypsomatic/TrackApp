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

	def edit
		@goal = current_user.goals.find(goal_params[:id])
	end

	def update
		@goal = current_user.goals.find(goal_params[:id])
		respond_to do |format|
			if @goal.update(goals_params)
				format.html { redirect_to goal_path(@goal), notice: "Goal was updated" }
			else
				format.html { render 'edit' }
			end
		end
	end

	def destroy
		Goal.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to goals_path }
    end
	end

	private

	def goals_params
		params.require(:goal).permit(:objective, :weekly_frequency, :weekly_quantity, :weight,
			datapoints_attributes: [:id, :date, :amount, :_destroy])
	end

	def goal_params
		params.permit(:id)
	end
end
