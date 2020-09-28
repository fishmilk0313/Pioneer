class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :topics, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 8 }
end
