class Message < ApplicationRecord
  belongs_to :user
  after_create :send_email

  private

  def send_email
    UserMailer.with(message: self).message_perso.deliver_later
  end

end
