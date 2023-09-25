class User < ApplicationRecord
  has_many :journals, dependent: :destroy, inverse_of: :user
  has_one_attached :profile_picture
  has_secure_password :password, validations: true
  after_initialize :set_default_role, if: :new_record?

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :profile_picture,
            blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..(5.megabytes) }

  enum role: %i[user admin]

  def set_default_role
    self.role ||= :user
  end
end
