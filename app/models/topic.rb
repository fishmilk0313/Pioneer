class Topic < ApplicationRecord
  attachment :image

  belongs_to :category

  def self.word_find(find,word)
    if find == "forward_match"
      @topic = Topic.where("title LIKE?","#{word}%")
    elsif find == "backward_match"
 　　　@topic = Topic.where("title LIKE?","%#{word}")
  　elsif find == "perfect_match"
 　　　@topic = Topic.where("#{word}")
    elsif find == "partial_match"
   　　@topic = Topic.where("title LIKE?","%#{word}%")
    else
      @topic = Topic.all
    end
  end
end