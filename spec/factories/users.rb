# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :owner, class: User do
    email Faker::Internet.email
    password 'password'
    password_confirmation 'password'
  end
  factory :traveler, class: User do
    email Faker::Internet.email
    password 'password'
    password_confirmation 'password'
  end
end
