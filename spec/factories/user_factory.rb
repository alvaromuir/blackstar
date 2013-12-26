

FactoryGirl.define do
  factory :user do
    name "devuser"
    email "sample@example.com"
    password "password12345"
    password_confirmation "password12345"

    factory :admin_user do
      admin true
    end 

  end
end