class UserController < ApplicationController

	def new 
		@user = User.new
	end

	#create new user
	def create
		@user = User.new

		#if a user with the same username already exists, then return to the sign up page.
		#the second argument to redirect_to will display an error message on the sign up page.
		if (User.where username: params[:user][:username]).any?
			@error_message = "A user with that username already exists. Please choose another username."
			redirect_to '/signup', flash: {error_message: @error_message}
		else

			#else, create a new user account with the relevant information
			@user.username = params[:user][:username]
			@user.password_digest = BCrypt::Password.create(params[:user][:password])

			#then log the user in and redirect to the index page "/"
			if @user.save
				session[:user_id] = @user.id
				redirect_to '/'
			else
				redirect_to '/signup'
			end
		end
	end
end
