class TaskController < ApplicationController

	#require that a user is logged in before being able to view any of the task pages, including the index
	before_action :require_user

	#display all tasks owned by the current user
	def index
		@tasks = Task.where user: current_user
	end

	def new
		@task = Task.new
	end

	#create new task and assign to the current user. then redirect to index page.
	def create
		@task = Task.new task_params
		@task.user = current_user

		if @task.save
			redirect_to "/"
		else
			redirect_to "/new"
		end
	end

	#display a specific task in detail. 
	def show
		@task = Task.find(params[:id])
		@tags = @task.tags

		#as tasks are referred to in the url by an integer id, it might be possible for a user to view and modify
		#the tasks of another user. this conditional will prevent such an occurrence.
		redirect_to "/" unless @task.user.id == current_user().id
	end

	#edit a task. this prepares the edit task form for the user to fill out
	def edit
		@task = Task.find(params[:id])
		@tags = @task.tags

		#as tasks are referred to in the url by an integer id, it might be possible for a user to view and modify
		#the tasks of another user. this conditional will prevent such an occurrence.
		redirect_to "/" unless @task.user.id == current_user().id
	end

	#update a task. this makes the necessary changes to the task's tuple in the db.
	def update
		@task = Task.find(params[:id])
		
		redirect_to "/" unless @task.user.id == current_user().id

		if @task.update_attributes task_params
			redirect_to action: "show", id: @task.id
		else
			render "edit"
		end
	end

	#delete a task
	def destroy
		@task = Task.find(params[:id])
		
		redirect_to "/" unless @task.user.id == current_user().id

		#as each tagging represents a mapping of a tag to a task, there is no longer any need for the taggings that
		#belong to a task once the task is destroyed. hence we destroy all these taggings as well to save space in the db.
		if @task.destroy && @task.taggings.destroy_all
			redirect_to "/"
		else
			render "edit"
		end
	end
	
	def search
	end

	#display the search results after the user uses the search form.
	def results

		#obtain the necessary information from the search form
		search_parameters = search_params
		search_content = search_parameters[:search_content]
		search_tag = search_parameters[:search_tag]
		search_type = search_parameters[:search_type]

		@results = []

		#this conditional checks for the type of search that the user wishes to conduct. different steps must be
		#undertaken for each case.
		if search_type == "or"

			#check if there exists non-whitespace content in the Search content textbox
			if search_content.strip != ""

				#using an sql query, obtain all items from the database that have the search content as a substring,
				#AND which were created by the same user.
				@results += Task.where "head LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
				@results += Task.where "body LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
			end
			
			if search_tag.strip != ""
				@matched_tags = Tag.where name: search_tag, user: current_user

				#check if there exists a tag which matches the entered Search tag. 
				if @matched_tags.any?

					#if there is, then add all tasks with that tag to the results page
					@matched_tags[0].tasks.each do |t|
						@results.append t
					end
				end
			end

		#this elsif block is very similar to the block above, except one small change which is pointed out through comments
		elsif search_type == "and"

			temp_results = []

			if search_content.strip != ""
				temp_results += Task.where "head LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
				temp_results += Task.where "body LIKE ? AND user_id=?", "%" + search_content + "%", current_user().id
			end
			
			if search_tag.strip != ""

				@matched_tags = Tag.where name: search_tag, user: current_user

				if @matched_tags.any?

					#unlike in the "or" scenario, the "and" scenario only searches through the tasks that contain the desired
					#content.
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

		#in the event that the same task appears more than once (possibly due to matching both the content AND the tag
		#in an "or" search), we remove the duplicates.
		@results.uniq!

		@tags = Tag.all
	end


	#private functions that we can use to obtain form data
	private

	def task_params
		params.require(:task).permit(:head, :body)
	end

	def search_params
		params.require(:search_term).permit(:search_content, :search_tag, :search_type)
	end
end
