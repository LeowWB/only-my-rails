class TaggingController < ApplicationController

	#create a new tagging. a tagging is a mapping of a tag to a task.
	#taggings implement a many-to-many relationship between tags and tasks.
	def create
		
		#when a user tags a task, we first check if an identical tag exists (perhaps with another class)
		existing_tag = Tag.where(name: tag_params.fetch(:name), user: current_user)

		#if an identical tag exists then there is no need to create a new tag.
		if existing_tag.any?

			#create a new tagging.
			@tagging = Tagging.new
			@tagging.tag = existing_tag[0]
			@tagging.task = Task.find(params[:id])

			if @tagging.save
				redirect_to "/tasks/#{params[:id]}/"
			else
				render "/"
			end

		#if no identical tag exists, then we need to create a new tag and a new tagging.
		else
			
			#create new tag
			@tag = Tag.new tag_params
			@tag.user = current_user

			#create new tagging
			@tagging = Tagging.new
			@tagging.tag = @tag
			@tagging.task = Task.find(params[:id])

			if @tag.save && @tagging.save
				redirect_to "/tasks/#{params[:id]}/"
			else
				render "/"
			end
		end
	end

	#destroy an existing tagging
	def destroy
		@tag = Tag.find params[:tag_id]
		@task = Task.find params[:id]
		@tagging = Tagging.where task: @task, tag: @tag

		if @tagging[0].destroy

			#after destroying a tagging, this conditional checks to ensure that the related tag has some other taggings
			#remaining. if this tag no longer has any other taggings, then it means that there is no longer any task
			#with that tag. we hence destroy that tag to save space.

			if @tag.taggings.any?
				redirect_to task_path(@task)

			elsif @tag.destroy
				redirect_to task_path(@task)

			else
				render "/"

			end

		else
			render "/"
		end
	end

	#this private method allows us to obtain form data from the Add tag form.
	private

	def tag_params
		params.require(:tag).permit(:name)
	end
end
