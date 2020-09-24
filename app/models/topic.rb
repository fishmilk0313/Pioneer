class Topic < ApplicationRecord
  attachment :image

  belongs_to :category

  validates :title,
            :presence => {:message => "が入力されていません。" },
            :length => { :maximum => 10, :message => "は１０文字以内です。"}
  
  validates :text,
            :presence => {:message => "が入力されていません。" },
            :length => { :maximum => 50, :message => "は50文字以内です。"}

  validates :category, :presence => {:message => "を選択してください" }
  validates :image, :presence => {:message => "を選択してください" }


  def self.word_find(find,word)
     def self.word_find(find,word)
      if find == "forward_match"
        @topic = Topic.where("title LIKE?","#{word}%")
      elsif find == "backward_match"
        @topic = Topic.where("title LIKE?","%#{word}")
      elsif find == "perfect_match"
        @topic = Topic.where("title","#{word}")
      elsif find == "partial_match"
         @topic = Topic.where("title LIKE?","%#{word}%")
      else
         @post = Post.all
      end
    end
  end
end