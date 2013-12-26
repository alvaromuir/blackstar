require 'spec_helper'

describe CategoriesController do
  it "displays an error for a missing category" do
    get :show, id: "test-category-not-here"
    expect(response).to redirect_to(categories_path)
    message = "The category you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end
end
