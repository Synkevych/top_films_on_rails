class UserMailer < ApplicationMailer
  #before_processing :ensure_user 

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end

  def ensure_user
    if user.nil? 
      bounce_with UserMailer.missing(inbound_email)
    end
  end
end
