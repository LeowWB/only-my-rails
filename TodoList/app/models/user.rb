class User < ApplicationRecord

	has_secure_password 

	has_many :tags
	has_many :tasks
end
