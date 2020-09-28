class Post < ApplicationRecord
  attachment :image

  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title,
            :presence => { :message => "が入力されていません。" },
            :length => { :maximum => 10, :message => "１０文字以内です。" }

  validates :text,
            :presence => { :message => "が入力されていません。" },
            :length => { :maximum => 50, :message => "50文字以内が投稿可能です。" }

  validates :category, :presence => { :message => "を選択してください" }
  validates :image, :presence => { :message => "を選択してください" }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
   end

  # いいねの通知
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end

  # コメントの通知
  def create_notification_comment!(current_user, comment_id)
    # 　同じ投稿にコメントしているユーザーに通知を送る
    temp_ids = Comment.where(post_id: id).where.not("user_id=? or user_id=?", current_user.id, user_id).select(:user_id).distinct
    # 　取得したユーザー達へ通知を作成
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # 投稿者へ通知を作成
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def self.word_find(find, word)
    if find == "forward_match"
      @post = Post.where("title LIKE?", "#{word}%")
    elsif find == "backward_match"
      @post = Post.where("title LIKE?", "%#{word}")
    elsif find == "perfect_match"
      @post = Post.where("title", "#{word}")
    elsif find == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
 end
end
