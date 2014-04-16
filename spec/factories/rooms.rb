FactoryGirl.define do
  factory :room do
    location Faker::Address.city
    price '12.99'
  end
end
