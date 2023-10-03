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

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end 

  private 

  def registration_confirmation
    UserMailer.with(user: self).registration_confirmation.deliver_now 
  end
end
