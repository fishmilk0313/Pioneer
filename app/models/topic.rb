class Topic < ApplicationRecord
  attachment :image

  belongs_to :category

  validates :title,
            :presence => { :message => "が入力されていません。" },
            :length => { :maximum => 20, :message => "は20文字以内です。" }

  validates :text,
            :presence => { :message => "が入力されていません。" },
            :length => { :maximum => 300, :message => "は300文字以内です。" }

  validates :category, :presence => { :message => "を選択してください" }
  validates :image, :presence => { :message => "を選択してください" }

  def self.word_find(find, word)
    if find == "forward_match"
      @topic = Topic.where("title LIKE?", "#{word}%")
    elsif find == "backward_match"
      @topic = Topic.where("title LIKE?", "%#{word}")
    elsif find == "perfect_match"
      @topic = Topic.where("title", "#{word}")
    elsif find == "partial_match"
      @topic = Topic.where("title LIKE?", "%#{word}%")
    else
      @topic = Post.all
    end
    end
end
