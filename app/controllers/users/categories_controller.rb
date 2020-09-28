class Users::CategoriesController < ApplicationController
  before_action :authenticate_user!

  # GET /categories
  # GET /categories.json
  def show
    @posts = Post.where(Category_id: params[:id])
    @topics = Topics.where(Category_id: params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :is_active)
  end
end
