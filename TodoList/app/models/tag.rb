class Tag < ApplicationRecord
	has_many :taggings
	has_many :tasks, through: :taggings
	belongs_to :user
end
