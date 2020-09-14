class User < ApplicationRecord
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attachment :profile_image

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  # def create_notification_follow!(current_user)
  #   temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?",current_user.id, id, 'follow'])
  #   if temp.blank?
  #     notification = current_user.active_notifications.new(
  #       visited_id: id,
  #       action: 'follow'
  #       )
  #     notification.save if notification.valid?
  #   end
  # end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
