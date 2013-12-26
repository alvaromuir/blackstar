

require 'spec_helper'
feature 'Creating Categories' do
  scenario "can create a project" do
    visit '/'
    click_link 'New Category'

    fill_in 'Name', with: 'HTML5 CSS3'
    fill_in 'Description', with: 'All things browser markup'
    click_button 'Create Category'

    expect(page).to have_content('Category has been created.')

    category = Category.where(name: "HTML5 CSS3").first

    expect(page.current_url).to eql(category_url(category))

    title = "Categories | HTML5 CSS3 => Blackstar"
    expect(page).to have_title(title)
  end
end