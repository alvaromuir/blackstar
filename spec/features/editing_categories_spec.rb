

require 'spec_helper'

feature "Editing Categories" do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))
    FactoryGirl.create(:category, name: 'HTML5 CSS3')

    visit '/'
    click_link "HTML5 CSS3"
    click_link "Edit Category"
  end

  scenario "Updating Categories" do
    fill_in "Name", with: "Responsive HTML5 CSS3"
    click_button "Update Category"

    expect(page).to have_content("Category has been updated.")
  end

  scenario "Updating a category with invalid attributes is bad" do
    fill_in "Name", with: ""
    click_button "Update Category"
    expect(page).to have_content("Category has not been updated.")
  end
end