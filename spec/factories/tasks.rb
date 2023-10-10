FactoryBot.define do
  factory :task do
    title { FFaker::Lorem.sentence }
    description { FFaker::Lorem.sentence }
  end
end
