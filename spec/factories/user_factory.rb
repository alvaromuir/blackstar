

FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com" }
  
  factory :user do
    name "devuser"
    email { generate(:email) }
    password "password12345"
    password_confirmation "password12345"

    factory :admin_user do
      admin true
    end 
  end
end