class UserController < ApplicationController

	def new 
		@user = User.new
	end

	def create
		@user = User.new
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
