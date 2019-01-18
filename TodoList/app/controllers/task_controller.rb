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

	def results

		search_parameters = search_params
		search_content = search_parameters[:search_content]
		search_tag = search_parameters[:search_tag]

		@results = []

		if search_content.strip != ""
			@results += Task.where "head LIKE ?", "%" + search_content + "%"
			@results += Task.where "body LIKE ?", "%" + search_content + "%"
		end
		
		if search_tag.strip != ""
			@matched_tags = Tag.where name: search_tag

			@matched_tags.each do |tg|
				@results.append tg.task
			end
		end

		@results.uniq!

		@tags = Tag.all
	end


	private

	def task_params
		params.require(:task).permit(:head, :body)
	end

	def search_params
		params.require(:search_term).permit(:search_content, :search_tag)
	end
end
