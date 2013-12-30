

require 'spec_helper'

feature "Seed Data" do
  scenario "The basics" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "admin@example.com").first!
    category = Category.where(name: "Blackstar Beta").first!
	end 
end