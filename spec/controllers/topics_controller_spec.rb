

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
end