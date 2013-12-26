

require 'spec_helper'

feature "Deleting categories" do
  scenario "destroying a category" do
    FactoryGirl.create(:category, name: "HTML5 CSS3")

    visit '/'
    click_link 'HTML5 CSS3'
    click_link 'Delete Category'

    expect(page).to have_content('Category has been deleted.')
  end
end