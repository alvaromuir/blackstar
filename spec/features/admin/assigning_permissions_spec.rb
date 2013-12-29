

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
end