class Request < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :bio, presence: true
  validates :phone_number, presence: true
  # regex find on stackoverflow
  validates :phone_number, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/ }
  validates :bio, presence: true
  validates :bio, length: { minimum: 20 }

  enum status: { unconfirmed: 0, confirmed: 1, accepted: 2, expired: 3 }

  after_create :send_confirmation_email
  after_commit :Add_ranking

  private

  def send_confirmation_email
    RequestMailer.with(request: self).confirmation.deliver_now
  end

  def Add_ranking
      max_ranking = Request.maximum('ranking').to_i
      if (self.accepted? && self.ranking.nil?)
        self.ranking = max_ranking + 1
      end
      RequestMailer.with(request: self).ranking.deliver_now if self.accepted?
  end

end
