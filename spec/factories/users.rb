require 'ffaker'

confirm_token = SecureRandom.urlsafe_base64.to_s
password = FFaker::Internet.password(8)
FactoryBot.define do
  factory :user do
    username { FFaker::Lorem.sentence }
    last_name { FFaker::Lorem.sentence }
    role { :user }
    email { FFaker::Lorem.sentence }
    password { password }
    password_confirmation { password }
    email_confirmed {}
    confirm_token { confirm_token }
  end
end
