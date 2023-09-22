class UserMailer < ApplicationMailer
	def welcome_mail
    mail(
      :subject => 'Welcome to Journey',
      :to  => @user.email,
      :from => 'sender@example.com',
      :html_body => 'HTML body goes here',
      :track_opens => 'true')
  end

  def signup_email
    @user = params[:user] 
    mail(to: @user.email, subject: 'Welcome to Journey!') 
  end 
end
