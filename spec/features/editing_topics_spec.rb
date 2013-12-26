

require 'spec_helper'

feature "Editing Topics" do 
  let!(:category) { FactoryGirl.create(:category) }
  let!(:topic) { FactoryGirl.create(:topic, category: category) }

  before do
    visit '/'
    click_link category.name
    click_link topic.title
    click_link "Edit Topic"
  end

  scenario "Updating a topic" do
    fill_in "Title", with: "Responsive Design for Tablets"
    click_button "Update Topic"

    expect(page).to have_content("Topic has been updated")

    within("#topic h2") do
      expect(page).to have_content("Responsive Design for Tablets")
    end

    expect(page).to_not have_content(topic.title)
  end

  scenario "Updating a topic with invalid inforomation" do
    fill_in "Title", with: ""
    click_button "Update Topic"

    expect(page).to have_content("Topic has not been updated")
  end
end