class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @favorite = @user.favorite_posts.page(params[:page]).per(6)
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(user_id: current_user.id)
    favorite.save
    @post.create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end
