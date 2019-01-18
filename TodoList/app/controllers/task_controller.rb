class TaskController < ApplicationController

	def index
		@tasks = Task.all
		@tags = Tag.all
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

	def show
		@task = Task.find(params[:id])
		@tags = @task.tags
	end

	def edit
		@task = Task.find(params[:id])
		@tags = @task.tags
	end

	def update
		@task = Task.find(params[:id])

		if @task.update_attributes task_params
			redirect_to action: "show", id: @task.id
		else
			render "edit"
		end
	end

	def destroy
		@task = Task.find(params[:id])

		if @task.destroy
			redirect_to "/"
		else
			render "edit"
		end
	end
	
	def search
	end


	private

	def task_params
		params.require(:task).permit(:head, :body)
	end
end
