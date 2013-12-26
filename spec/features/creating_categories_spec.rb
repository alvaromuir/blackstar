

require 'spec_helper'

feature 'Creating Categories' do
  before do
    visit '/'

    click_link 'New Category'      
  end

  scenario "can create a project" do
    fill_in 'Name', with: 'HTML5 CSS3'
    fill_in 'Description', with: 'All things browser markup'
    click_button 'Create Category'

    expect(page).to have_content('Category has been created.')

    category = Category.where(name: "HTML5 CSS3").first

    expect(page.current_url).to eql(category_url(category))

    title = "Categories | HTML5 CSS3 => Blackstar"
    expect(page).to have_title(title)
  end

  scenario "can't create a category without a name" do
    click_button 'Create Category'

    expect(page).to have_content("Category has not been created.")
    expect(page).to have_content("Name can't be blank")
  end
end