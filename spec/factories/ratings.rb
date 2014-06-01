FactoryGirl.define do
  factory :rating do
    stars Random.rand(1..5)
    review "Mediocre at best, phenomenal at worst"
  end
end
