class UserMailer < ApplicationMailer
  default_url_options[:host] = 'localhost'

  def registration_confirmation(user)
    @user = user
    mail(from: t('mailer.from'), to: "#{user.email}", subject: t('mailer.subject'))
 end
end
