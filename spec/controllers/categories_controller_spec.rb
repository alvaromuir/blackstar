require 'spec_helper'

describe CategoriesController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
  end

  it "displays an error for a missing category" do
    get :show, id: "test-category-not-here"

    expect(response).to redirect_to(categories_path)
    message = "The category you were looking for could not be found."

    expect(flash[:alert]).to eql(message)
  end

  context "standard users" do
    { new: :get,
      create: :post,
      edit: :get,
      update: :put,
      destroy: :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(user)
        send(method, action, :id => FactoryGirl.create(:category))
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eql("You must be an admin to do that.")
      end
    end 
  end
    
  it "cannot access the show action without permission" do
    category = FactoryGirl.create(:category)
    get :show, id: category.id
    expect(response).to redirect_to(categories_path)
    expect(flash[:alert]).to eql("The category you were looking for could not" +
                                " be found.")
  end
end
