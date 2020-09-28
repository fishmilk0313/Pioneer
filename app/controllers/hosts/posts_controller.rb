class Hosts::PostsController < ApplicationController
  before_action :set_categories, only: [:new, :edit, :index, :create, :update]
  before_action :authenticate_host!

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.page(params[:page]).per(6)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save!
      redirect_to users_posts_path
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to hosts_posts_path
  end

  def self.search(search, word)
    if search == "forward_match"
      　　 @topic = Topic.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      　　　@post = Post.where("title LIKE?", "%#{word}")
    elsif search == "perfect_match"
      　　　@post = Post.where("#{word}")
    elsif search == "partial_match"
      　　　@post = Post.where("title LIKE?", "%#{word}%")
    else
      　　　@post = Post.all
    end
   end

  private

  def set_categories
    @categories = Category.where(is_active: true)
  end

  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :text, :image)
  end
end
