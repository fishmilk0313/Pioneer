class User < ApplicationRecord
	validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    attachment :profile_image

    has_many :posts, dependent: :destroy
    # has_many :comments, dependent: :destroy
    # has_many :favorites, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
