FactoryGirl.define do
  factory :property do
    name { FFaker::Property.property_name }
    address "94 Wycliffe Ave"
    description "Lorem Ipsum Test 123"
    lat 5
    lng 6
    user
  end

end

# FactoryGirl.create :property