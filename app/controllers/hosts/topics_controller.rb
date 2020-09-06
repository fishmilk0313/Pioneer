class Hosts::TopicsController < ApplicationController
  before_action :set_categories, only: [:new, :edit, :index, :create, :update]


  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.order(updated_at: :desc).limit(1)
    @topic = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to hosts_topics_path
    else 
      render :new
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categories
      @categories = Category.where(is_active: true)
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:category_id, :title, :text, :image)
    end
end
