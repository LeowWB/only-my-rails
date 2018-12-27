class TaskController < ApplicationController

	def index
		@tasks = Task.all
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new task_params

		if @task.save
			redirect_to "/"
		else
			redirect_to "/new"
		end
	end

	

	private

	def task_params
		params.require(:task).permit(:head, :body)
	end
end
