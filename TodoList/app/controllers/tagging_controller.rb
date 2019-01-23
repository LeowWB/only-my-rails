class TaggingController < ApplicationController

	def create
		
		existing_tag = Tag.where(name: tag_params.fetch(:name))

		if existing_tag.any?

			@tagging = Tagging.new
			@tagging.tag = existing_tag[0]
			@tagging.task = Task.find(params[:id])

			if @tagging.save
				redirect_to "/tasks/#{params[:id]}/"
			else
				render "/"
			end

		else
			
			@tag = Tag.new tag_params

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

	def destroy
		@tag = Tag.find params[:tag_id]
		@task = Task.find params[:id]
		@tagging = Tagging.where task: @task, tag: @tag

		if @tagging[0].destroy
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

	private

	def tag_params
		params.require(:tag).permit(:name)
	end
end
