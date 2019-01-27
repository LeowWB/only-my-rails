class SessionController < ApplicationController

	def new
	end

	#call this method when a user logs in
	def create
		@user = User.find_by_username(params[:session][:username])

		#ensure that a user with the username exists, AND the password hashes are identical
		if @user && @user.authenticate(params[:session][:password])

			#log the user in by starting a new session, then redirect to the main index page "/"
			session[:user_id] = @user.id
			redirect_to "/"
		else
			#redirect back to login page if the username and password do not match the existing entries in the database
			redirect_to "/login", flash: {error_message: "We did not recognize that combination of username and password. Please try again."}
		end
	end

	#call this to log a user out.
	def destroy
		session[:user_id] = nil
		redirect_to '/login'
	end

end
