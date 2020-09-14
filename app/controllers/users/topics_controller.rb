class Users::TopicsController < ApplicationController
  before_action :set_categories, only: [:show, :index]

  def index
    @topic = Topic.order(updated_at: :desc).limit(1)
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  private

  def set_categories
    @categories = Category.where(is_active: true)
  end
end
