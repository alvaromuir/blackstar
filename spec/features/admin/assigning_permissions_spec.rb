

require 'spec_helper'

feature "Assinging permissions" do
  let!(:admin)    { FactoryGirl.create(:admin_user) }
  let!(:user)     { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:category) }
  let!(:topic)    { FactoryGirl.create(:topic,
                                    category: category, 
                                    user: user) }

  before do
    sign_in_as!(admin)

    click_link "Admin"
    click_link "Users"
    click_link user.email
    click_link "Permissions"
  end

  scenario "Viewing a category" do
    check_permission_box "view", category


    click_button "Update"
    click_link "Sign out"
    
    sign_in_as!(user)
    expect(page).to have_content(category.name)
  end

  scenario "Creating topics for a category" do
    check_permission_box "view", category
    check_permission_box "create_topics", category
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    click_link category.name
    click_link "New Topic"
    fill_in "Title", with: "HTML5!"
    fill_in "Description", with: "Browser support?"
    click_button "Create"
    expect(page).to have_content("Topic has been created.")
  end

  scenario "Updating a topic for a category" do
    check_permission_box "view", category
    check_permission_box "edit_topics", category
    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    click_link category.name
    click_link topic.title
    click_link "Edit Topic"
    fill_in "Title", with: "Mobile browser suport?"
    click_button "Update Topic"

    expect(page).to have_content("Topic has been updated")
  end

  scenario "Deleting a topic for a category" do
    check_permission_box "view", category
    check_permission_box "delete_topics", category

    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    click_link category.name
    click_link topic.title
    click_link "Delete Topic"

    expect(page).to have_content("Topic has been deleted.")
  end
end