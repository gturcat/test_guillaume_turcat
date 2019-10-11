class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.usermailer_mailer.message_perso.subject
  #
  def message_perso
    @message = params[:message] # Instance variable => available in view
    mail(to: @message.to, subject: @message.subject)
  end
end
