class CategoriesController < ApplicationController

  def index
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
      # nothing, yet
    end
  end

  def show
    @category = Category.find(params[:id])
  end
  
  private

    def category_params
      params.require(:category).permit(:name, :description)
    end
end
