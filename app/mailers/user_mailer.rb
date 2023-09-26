class UserMailer < ApplicationMailer
  def welcome_mail
    mail(
      :subject => 'Welcome to Journey',
      :to  => @user.email,
      :from => 'sender@example.com',
      :html_body => 'HTML body goes here',
      :track_opens => 'true')
  end

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration Confirmation")
 end
end
