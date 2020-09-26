class Users::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [:show, :index]

  def index
    @topic = Topic.order(updated_at: :desc).limit(1)
    @topics = Topic.page(params[:page]).per(4)
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def contents
    @topics = Topic.where(Category_id: params[:id])
    @categories = Category.where(is_active: true)
  end

  private

  def set_categories
    @categories = Category.where(is_active: true)
  end
end
