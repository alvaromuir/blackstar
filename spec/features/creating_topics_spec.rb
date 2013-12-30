

require 'spec_helper'

feature "Creating Topics" do  
  before do
    category = FactoryGirl.create(:category)
    user = FactoryGirl.create(:user)
    @email = user.email
    define_permission!(user, "view", category)
    define_permission!(user, "create topics", category)
    sign_in_as!(user)

    click_link category.name
    click_link 'New Topic'
  end

  scenario "Creating a topic" do 
    fill_in 'Title', with: "Responsive mobile design"
    fill_in 'Description', with: "All things mobile devices"
    click_button "Create Topic"

    expect(page).to have_content("Topic has been created.")

    within "#topic #author" do
      expect(page).to have_content("Created by #{@email}")
    end
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

  scenario "Creating a topic with an attachment" do 
    fill_in "Title", with: "Sceenshot for media queries"
    fill_in "Description", with: "Should I design for all tablet sizes?"
    attach_file "File", "spec/fixtures/media_queries.jpg"
    click_button "Create Topic"

    expect(page).to have_content("Topic has been created.")

    within("#topic .asset") do
      expect(page).to have_content("media_queries.jpg")
    end
  end
end