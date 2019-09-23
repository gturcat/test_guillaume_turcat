class Request < ApplicationRecord
  validates :name, presence: true #tested
  validates :email, uniqueness: true #tested
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } #tested
  validates :bio, presence: true #tested
  validates :phone_number, presence: true #tested
  # regex find on stackoverflow
  validates :phone_number, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/ } #tested
  validates :bio, presence: true #tested
  validates :bio, length: { minimum: 20 } #tested
  belongs_to :user, optional: true

  enum status: { unconfirmed: 0, confirmed: 1, accepted: 2, expired: 3 }

  scope :old, -> { where("date_status < ?", 3.months.ago) }
  scope :need_to_expired, -> { where("date_status < ?", 67.days.ago) }
  scope :redorder_ranking, -> (ranking){ where("ranking > ?", ranking) }
  scope :first_in, -> (nbre) {where("ranking <= ?", nbre) }

  after_create :send_confirmation_email
  after_commit :add_ranking

def self.accept!(nbre) #tested
    requests = Request.confirmed.first_in(nbre)
    i = 0
    requests.each do |request|
      # le ranking est corrige (bug non resolu)
      i == 0 ? ranking = request.ranking : ranking = request.ranking.to_i - i
      #suppression du ranking"
      request.accepted!
      request.ranking = 0
      request.save! #travail minimum sinon traiter l'erreur
      i += 1
      # toutes les requetes dont les rangs sont superieur à la request supprimee gagnent une place
      requests_reranking = Request.redorder_ranking(ranking)
      requests_reranking.each do |request|
        request.ranking -= 1
        request.save! #travail minimum sinon traiter l'erreur
      end
      RequestMailer.with(request: request).admission.deliver_later
    end
  end

  private


  def send_confirmation_email
    RequestMailer.with(request: self).confirmation.deliver_later
  end

  def add_ranking #tested
    if self.ranking.nil?
      max_ranking = Request.maximum('ranking').to_i
       if self.confirmed?
        self.ranking = max_ranking + 1
        self.date_status = Date.today
        self.save
        RequestMailer.with(request: self).ranking.deliver_later
      end
    end
  end
end
