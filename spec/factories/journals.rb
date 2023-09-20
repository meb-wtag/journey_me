# frozen_string_literal: true

FactoryBot.define do
  factory :journal do
    title { FFaker::Lorem.sentence }
    description { FFaker::Lorem.sentence }
  end
end
