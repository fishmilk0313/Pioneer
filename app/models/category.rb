class Category < ApplicationRecord
	 has_many :posts
	 has_many :topics

	 validates :name, presence: true
end
