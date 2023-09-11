require 'ffaker'

FactoryBot.define do
  factory :user do
    first_name { FFaker::Lorem.sentence }
    last_name { FFaker::Lorem.sentence }
  end
end
