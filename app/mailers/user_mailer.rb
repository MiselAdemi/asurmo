class UserMailer < ApplicationMailer
	default from: "ademimisel@gmail.com"

  def invite(email, sender)
    @email = email
    @sender = sender

    mail to: @email
  end

	def send_multiple(emails, sender, message)
		@emails = emails.split(',')
		@sender = sender
		@message = message

		mail to: @emails, subject: "[Asurmo] #{@sender.full_name} notice"
	end
end
