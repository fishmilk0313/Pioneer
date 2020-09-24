class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy


  validates :comment,
   			:presence => {:message => "は空欄では投稿できません。" },
            :length => { :maximum => 20, :message => "は20文字以内です。"}
end
