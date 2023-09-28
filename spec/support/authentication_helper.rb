module AuthenticationHelper
  def sign_in_as!(user)
    user.email_confirmed = true
    session[:user_id] = user.id
  end
end

