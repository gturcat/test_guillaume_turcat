class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.confirmation.subject
  #
  def confirmation
    @request = params[:request] # Instance variable => available in view
    mail(to: @request.email, subject: 'Confirmation Adresse email')
  end

 def ranking
    @request = params[:request] # Instance variable => available in view
    mail(to: @request.email, subject: 'Votre place dans la list d attente')
  end

  def reconfirmation
    @request = params[:request] # Instance variable => available in view
    mail(to: @request.email, subject: 'Merci de confirmer votre intention de nous rejoindre')
  end

def confirm_expired
    @request = params[:request] # Instance variable => available in view
    mail(to: @request.email, subject: 'Vous avez été retirer de la liste d attente')
  end

end
