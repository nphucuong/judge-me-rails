# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    reviewer_name { Faker::Name.name }
    rating { Faker::Number.between(from: 0.0, to: 5.0) }
    product
  end
end
