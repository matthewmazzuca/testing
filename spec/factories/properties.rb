FactoryGirl.define do
  factory :property do
    name "Test Property"
    address { FFaker::Address.street_address }
    description "Lorem Ipsum Test 123"
    lat 43.7
    lng 79.4
    user
  end

end

# FactoryGirl.create :property

