class HomesController < ApplicationController
  def top
    @topic = Topic.order(updated_at: :desc).limit(4)
    @post = Post.order(updated_at: :desc).limit(4)
  end

  def about
  end
end
