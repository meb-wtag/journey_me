class User < ApplicationRecord
  has_many :journals, dependent: :destroy, inverse_of: :user
  has_one_attached :profile_picture
  has_secure_password :password, validations: true
  enum role: { admin: 0, supervisor: 1, user: 2}

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  #validates :profile_picture, content_type: ['image/png', 'image/jpeg'], size: { less_than: 5.megabytes }
end