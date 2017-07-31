class UserMailer < ApplicationMailer
	default from: "ademimisel@gmail.com"

  def invite(email, sender)
    @email = email
    @sender = sender

    mail to: @email
  end
end
