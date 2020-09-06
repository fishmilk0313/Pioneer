class Post < ApplicationRecord

	 attachment :image

	 belongs_to :category
	 belongs_to :user

end
