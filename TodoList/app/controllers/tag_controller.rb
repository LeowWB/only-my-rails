class TagController < ApplicationController

	def create
		@tag = Tag.new tag_params
		@tag.task_id = params[:id]

		if @tag.save
			redirect_to "/tasks/#{params[:id]}/"
		else
			render "/"
		end
	end


	def destroy
		@tag = Tag.find params[:tag_id]
		@task = Task.find params[:task_id]
		@tagging = Tagging.where task: :@task, tag: @tag

		if @tagging.destroy
			redirect_to task_path(Task.find params[:id])
		else
			render "/"
		end
	end


	private 

	def tag_params
		params.require(:tag).permit(:name)
	end
end
