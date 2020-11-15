FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    language { "HTML" }
    code { Faker::Lorem.paragraph }
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end
