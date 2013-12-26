class CategoriesController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category has been created."
      redirect_to @category
    else
      flash[:notice] = "Category has not been created."
      render "new"
    end
  end

  def show
    # set_category
  end

  def edit
    # set_category
  end

  def update
    # set_category
    if @category.update(category_params)
      flash[:notice] = "Category has been updated."
      redirect_to @category
    else
      flash[:notice] = "Category has not been updated."
      render "edit"
    end
  end

  def destroy
    # set_category
    @category.destroy
    flash[:notice] = "Category has been deleted."
    redirect_to categories_path
  end
  
  private

    def category_params
      params.require(:category).permit(:name, :description)
    end

    def set_category
      @category = Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The category you were looking" +
                      " for could not be found."
      redirect_to categories_path
    end
end