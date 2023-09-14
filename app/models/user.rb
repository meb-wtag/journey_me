class User < ApplicationRecord
  has_secure_password :password, validations: true
  enum role: { admin: 0, supervisor: 1, user: 2}

  validates :username, presence: true, uniqueness: true
end
