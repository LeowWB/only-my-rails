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



	private 

	def tag_params
		params.require(:tag).permit(:name)
	end
end
