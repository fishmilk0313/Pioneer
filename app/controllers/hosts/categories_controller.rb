class Hosts::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_host!

  # GET /categories
  # GET /categories.json
  def index
    @category = Category.new
    @categories = Category.page(params[:page]).per(10)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to hosts_categories_path
    else
      @categories = Category.all
      render(:index)
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to hosts_categories_path
    if @category.is_active == false
      @category.posts.each do |post|
        post.is_active = false
        post.save
      end
      @category.topics.each do |topic|
        topic.is_active = false
        topic.save
      end
    else @category.is_active == true
         @category.posts.each do |post|
           post.is_active = true
           post.save
         end
         @category.topics.each do |topic|
           topic.is_active = true
           topic.save
         end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
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
