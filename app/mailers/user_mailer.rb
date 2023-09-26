class UserMailer < ApplicationMailer
  default_url_options[:host] = 'localhost'

  def registration_confirmation(user)
    @user = user
    mail(from: 'from@example.com', to: "#{user.email}", subject: 'Registration Confirmation')
 end
end
