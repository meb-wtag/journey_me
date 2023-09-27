require 'ffaker'

password = FFaker::Internet.password(8)
FactoryBot.define do
  factory :user do
    username { FFaker::Lorem.sentence }
    last_name { FFaker::Lorem.sentence }
    role { :user }
    password { password }
    password_confirmation { password }
  end
end
