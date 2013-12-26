

require 'spec_helper'

describe TopicsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:topic) { FactoryGirl.create(:topic,
                                    category: category,
                                    user: user) }
  context "standard users" do
    it "cannot access a topic for a category" do
      sign_in(user)
      get :show, :id => topic.id, :category_id => category.id
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The category you were looking for could" +
                                  " not be found.")
    end 
  end

  context "with permission to view the category" do
    before do
      sign_in(user)
      define_permission!(user, "view", category)
    end

    def cannot_create_topics!
      response.should redirect_to(category)
      message = "You cannot create topics on this category."
      flash[:alert].should eql(message)
    end
      it "cannot begin to create a topic" do
        get :new, category_id: category.id
        cannot_create_topics!
    end
    it "cannot create a topic without permission" do
      post :create, category_id: category.id
      cannot_create_topics!
    end
  end
end