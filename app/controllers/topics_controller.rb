class TopicsController < ApplicationController
  before_action :require_signin!
  before_action :set_category
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]

  def new
    @topic = @category.topics.build
  end

  def create
    @topic = @category.topics.build(topic_params)
    @topic.user = current_user
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

  def edit
    # set_topic
  end

  def update
    if @topic.update(topic_params)
      flash[:notice] = "Topic has been updated."
      redirect_to [@category, @topic]
    else
      flash[:alert] = "Topic has not been updated."
      render "edit"
    end
  end

  def destroy
    @topic.destroy
    flash[:notice] = "Topic has been deleted."
    redirect_to @category
  end

  private
    def set_category
      @category = Category.for(current_user).find(params[:category_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The category you were looking for could not be found."
      redirect_to root_path
    end

    def set_topic
      @topic = @category.topics.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :description)
    end

    def authorize_create!
      if !current_user.admin? && cannot?("create topics".to_sym, @category)
        flash[:alert] = "You cannot create topics on this category."
        redirect_to @category
      end
    end

    def authorize_update!
      if !current_user.admin? && cannot?("edit topics".to_sym, @category)
        flash[:alert] = "You cannot edit topics on this category."
        redirect_to @category
      end
    end
end
