class TaskController < ApplicationController

	before_action :require_user

	def index
		@tasks = Task.where user: current_user
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new task_params
		@task.user = current_user

		if @task.save
			redirect_to "/"
		else
			redirect_to "/new"
		end
	end

	def show
		@task = Task.find(params[:id])
		@tags = @task.tags

		redirect_to "/" unless @task.user.id == current_user().id
	end

	def edit
		@task = Task.find(params[:id])
		@tags = @task.tags

		redirect_to "/" unless @task.user.id == current_user().id
	end

	def update
		@task = Task.find(params[:id])
		
		redirect_to "/" unless @task.user.id == current_user().id

		if @task.update_attributes task_params
			redirect_to action: "show", id: @task.id
		else
			render "edit"
		end
	end

	def destroy
		@task = Task.find(params[:id])
		
		redirect_to "/" unless @task.user.id == current_user().id

		if @task.destroy && @task.taggings.destroy_all
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
		search_type = search_parameters[:search_type]

		@results = []

		if search_type == "or"

			if search_content.strip != ""
				@results += Task.where "head LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
				@results += Task.where "body LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
			end
			
			if search_tag.strip != ""
				@matched_tags = Tag.where name: search_tag, user: current_user

				if @matched_tags.any?
					@matched_tags[0].tasks.each do |t|
						@results.append t
					end
				end
			end

		elsif search_type == "and"

			temp_results = []

			if search_content.strip != ""
				temp_results += Task.where "head LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
				temp_results += Task.where "body LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
			end
			
			if search_tag.strip != ""

				@matched_tags = Tag.where name: search_tag, user: current_user

				if @matched_tags.any?
					temp_results.each do |r|
						
						@matched_tags[0].tasks.each do |t|
							
							if t.id == r.id
								@results.append r
								break
							end
						end
					end
				end
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
		params.require(:search_term).permit(:search_content, :search_tag, :search_type)
	end
end
