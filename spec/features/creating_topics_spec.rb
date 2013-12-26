

require 'spec_helper'

feature "Creating Topics" do  
  before do
    FactoryGirl.create(:category, name: "HTML5 CSS3")

    visit '/'
    click_link 'HTML5 CSS3'
    click_link 'New Topic'
  end

  scenario "Creating a topic" do 
    fill_in 'Title', with: "Responsive mobile design"
    fill_in 'Description', with: "All things mobile devices"
    click_button "Create Topic"

    expect(page).to have_content("Topic has been created.")
  end

  scenario "Creating a topic withough valid attributes fail" do 
    click_button "Create Topic"

    expect(page).to have_content("Topic has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Any thoughts on CSS Frameworks?"
    fill_in "Description", with: "Anyone?"
    click_button "Create Topic"

    expect(page).to have_content("Topic has not been created.")
    expect(page).to have_content("Description is too short")
  end

end