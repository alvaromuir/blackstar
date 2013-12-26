

require 'spec_helper'

feature "Viewing categories" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:category) }
  
  before do
    sign_in_as!(user)
    define_permission!(user, :view, category)
  end

  scenario "Listing all categories" do
    visit '/'

    click_link category.name
    expect(page.current_url).to eql(category_url(category))

    FactoryGirl.create(:category, name: "Hidden")
    visit '/'
    expect(page).to_not have_content("Hidden")
    click_link category.name
  end 
end