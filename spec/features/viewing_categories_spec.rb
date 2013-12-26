

require 'spec_helper'

feature "Viewing categories" do
  scenario "Listing all categories" do
    category = FactoryGirl.create(:category, name: "HTML5 CSS3")
    visit '/'

    click_link 'HTML5 CSS3'
    expect(page.current_url).to eql(category_url(category))
  end 
end