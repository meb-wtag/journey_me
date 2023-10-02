class User < ApplicationRecord
  has_many :journals, dependent: :destroy, inverse_of: :user
  has_one_attached :profile_picture
  has_secure_password :password, validations: true

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :role, presence: true
  validates :password_confirmation, presence: true, on: :create
  validates :profile_picture,
            blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..(5.megabytes) }

  enum role: { user: 0, admin: 1 }
end
