# Preview all emails at http://localhost:3000/rails/mailers/usermailer_mailer
class UsermailerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/usermailer_mailer/message_perso
  def message_perso
    UsermailerMailer.message_perso
  end

end
