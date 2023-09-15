class User < ApplicationRecord
  has_many :journals, dependent: :destroy, inverse_of: :user

  has_secure_password :password, validations: true
  enum role: { admin: 0, supervisor: 1, user: 2}

  validates :username, presence: true, uniqueness: true
end