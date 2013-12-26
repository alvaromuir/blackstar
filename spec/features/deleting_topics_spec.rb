

require 'spec_helper'

feature "Deleting Topics" do
  let!(:category) { FactoryGirl.create(:category) }
  let!(:topic) { FactoryGirl.create(:topic, category: category) }

  before do
    visit '/'
    click_link category.name
    click_link topic.title
  end

  scenario "Deleting a topic" do
    click_link "Delete Topic"
    expect(page).to have_content("Topic has been deleted.")
    expect(page.current_url).to eq(category_url(category))
  end
end