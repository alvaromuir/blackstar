

require 'spec_helper'
feature 'Creating Categories' do
  scenario "can create a project" do
    visit '/'
    click_link 'New Category'

    fill_in 'Name', with: 'HTML5  CSS3'
    fill_in 'Description', with: 'All things browser markup'
    click_button 'Create Category'

    expect(page).to have_content('Category has been created.')
  end
end