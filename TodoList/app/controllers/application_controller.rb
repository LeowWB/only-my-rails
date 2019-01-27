class ApplicationController < ActionController::Base

	helper_method :current_user

	#returns the currently logged in user
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	#this function is called whenever a page is loaded. it ensures that, other than the Sign Up and Sign In pages,
	#no other pages can be accessed by a user who is not logged in.
	def require_user
		redirect_to "/login" unless current_user
	end
end
