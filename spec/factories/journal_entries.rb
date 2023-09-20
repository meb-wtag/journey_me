require 'ffaker'
FactoryBot.define do
  factory :journal_entry do
    journal
    title { FFaker::Lorem.sentence }
    content { FFaker::Lorem.sentence }
    goal { FFaker::Lorem.sentence }
  end
end
