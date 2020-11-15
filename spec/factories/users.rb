FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    profile { "I like " + Faker::Food.fruits + ". nice to meet you." }
  end

  trait :invalid do
    name { nil }
  end
end
