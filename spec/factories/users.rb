# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "gleb@addolabs.co"
    password "12345678"
    password_confirmation "12345678"
  end
end

# FactoryGirl.create :user
