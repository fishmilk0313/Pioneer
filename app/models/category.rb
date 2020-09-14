class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :topics, dependent: :destroy

  validates :name, presence: true
end
