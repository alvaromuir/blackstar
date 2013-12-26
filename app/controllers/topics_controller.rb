class TopicsController < ApplicationController
  before_action :set_category
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def new
    @topic = @category.topics.build
  end

  def create
    @topic = @category.topics.build(topic_params)
    if @topic.save
      flash[:notice] = "Topic has been created."
      redirect_to [@category, @topic]
    else
      flash[:alert] = "Topic has not been created."
      render "new"
    end
  end

  def show
    # set_topic
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_topic
      @topic = @category.topics.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :description)
    end
end
