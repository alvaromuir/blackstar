

require 'spec_helper'
feature "hidden links" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:topic) { FactoryGirl.create(:topic,
                                    category: category,
                                    user: user) }

  context "anonymous users" do
    scenario "cannot see the New Category link" do
      visit '/'
      assert_no_link_for "New Category"
    end

    scenario "cannot see the Edit Category link" do
      visit category_path(category)
      assert_no_link_for "Edit Category"
    end

    scenario "cannot see the Delete Category link" do
      visit category_path(category)
      assert_no_link_for "Delete Category"
    end
  end

  context "regular users" do
    before { sign_in_as!(user) }
    
    scenario "cannot see the New Category link" do
      visit '/'
      assert_no_link_for "New Category"
    end

    scenario "cannot see the Edit Category link" do
      visit category_path(category)
      assert_no_link_for "Edit Category"
    end

    scenario "cannot see the Delete Category link" do
      visit category_path(category)
      assert_no_link_for "Delete Category"
    end

    scenario "New topic link is shown to a user with persmission" do
      define_permission!(user, "view", category)
      define_permission!(user, "create topics", category)
      visit category_path(category)
      assert_link_for "New Topic"
    end

    scenario "New topic link hidden from a user with persmission" do
      define_permission!(user, "view", category)
      visit category_path(category)
      assert_no_link_for "New Topic"
    end

    scenario "Edit topic link is shown to a user with permission" do
      topic
      define_permission!(user, "view", category)
      define_permission!(user, "edit topics", category)
      visit category_path(category)
      click_link topic.title
      assert_link_for "Edit Topic"
    end

    scenario "Edit topic link is hidden from a user without permission" do
      topic
      define_permission!(user, "view", category)
      visit category_path(category)
      click_link topic.title
      assert_no_link_for "Edit Topic"
    end

    scenario "Delete topic link is shown to a user with permission" do
      topic
      define_permission!(user, "view", category)
      define_permission!(user, "delete topics", category)
      visit category_path(category)
      click_link topic.title
      assert_link_for "Delete Topic"
    end

    scenario "Delete topic link is hidden from a user without permission" do
      topic
      define_permission!(user, "view", category)
      visit category_path(category)
      click_link topic.title
      assert_no_link_for "Delete Topic"
    end
  end

  context "admin users" do
    before { sign_in_as!(admin) }
    scenario "can see the New Category link" do
      visit '/'
      assert_link_for "New Category"
    end

    scenario "can see the Edit Category link" do
      visit category_path(category)
      assert_link_for "Edit Category"
    end

    scenario "can see the Delete Category link" do
      visit category_path(category)
      assert_link_for "Delete Category"
    end

    scenario "New topic link is shown to admins" do
      visit category_path(category)
      assert_link_for "New Topic"
    end

    scenario "Edit topic link is shown to admins" do
      topic
      visit category_path(category)
      click_link topic.title
      assert_link_for "Edit Topic"
    end

    scenario "Delete topic link is shown to admins" do
      topic
      visit category_path(category)
      click_link topic.title
      assert_link_for "Delete Topic"
    end
  end 
end