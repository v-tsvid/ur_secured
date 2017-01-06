FactoryGirl.define do
  factory :url do
    url   { Faker::Internet.url }
    safe? { [true, false].sample }
  end
end
