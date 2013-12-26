require 'spec_helper'

describe CategoriesController do
  it "displays an error for a missing category" do
    get :show, id: "test-category-not-here"
    expect(response).to redirect_to(categories_path)
    message = "The category you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end

  let(:user) { FactoryGirl.create(:user) }
  context "standard users" do
    before do
      sign_in(user)
    end

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
end
