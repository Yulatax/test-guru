class FeedbackMailer < ApplicationMailer

  def send_feedback(params)

    @name = params[:name]
    @email = params[:email]
    @text = params[:message]

    admin_email = Admin.first.email

    mail to: [admin_email, subject: 'Contact us mailer']
  end
end