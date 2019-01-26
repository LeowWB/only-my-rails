class UserController < ApplicationController

	def new 
		@user = User.new
	end

	def create
		@user = User.new

		if (User.where username: params[:user][:username]).any?
			@error_message = "A user with that username already exists. Please choose another username."
			redirect_to '/signup', flash: {error_message: @error_message}
		else

			@user.username = params[:user][:username]
			@user.password_digest = BCrypt::Password.create(params[:user][:password])

			if @user.save
				session[:user_id] = @user.id
				redirect_to '/'
			else
				redirect_to '/signup'
			end
		end
	end
end
