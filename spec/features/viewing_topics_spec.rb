

require 'spec_helper'

feature "Viewing Topics" do
  before do
    html_css = FactoryGirl.create(:category, name: 'HTML5 CSS3')
    user = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic, 
                        category: html_css, 
                        title: "Responsive Design",
                        description: "All screens, all orientations.")
    topic.update(user: user)
    visit '/'
  end

  scenario "viewing a topics for a specific category" do
    click_link "HTML5 CSS3"

    expect(page).to have_content("Responsive Design")
    expect(page).to_not have_content("Angel Investors")

    click_link "Responsive Design"
    within("#topic h2") do
      expect(page).to have_content("Responsive Design")
    end

    expect(page).to have_content("All screens, all orientations.")
  end 
end