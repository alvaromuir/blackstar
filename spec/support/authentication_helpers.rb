

module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/signin'
    fill_in "Username", with: user.name
    fill_in "Password", with: user.password
    click_button 'Sign in'
    expect(page).to have_content("Signed in successfully.")
  end 
end

module AuthorizationHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end
end

module PermissionHelpers
  def define_permission!(user, action, thing)
    Permission.create!(user: user,
                       action: action,
                       thing: thing)
  end 
end

def check_permission_box(permission, object)
  check "permissions_#{object.id}_#{permission}"
end

RSpec.configure do |c|
  c.include AuthenticationHelpers, type: :feature
  c.include AuthorizationHelpers, type: :controller
  c.include PermissionHelpers
end