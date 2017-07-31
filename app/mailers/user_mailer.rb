class UserMailer < ApplicationMailer
	default from: "ademimisel@gmail.com"

  def invite(email)
    @email = email
    @sender = current_user

    mail to: @email
  end
end
