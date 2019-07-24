namespace :request do
  desc "Send reconfirmation mail"
  task confirm_again: :environment do
    requests = Request.confirmed.merge(Request.old)
    requests.each do |request|
      RequestMailer.with(request: request).reconfirmation.deliver_later
    end
  end
end

namespace :request do
  desc "expired request"
  task expired_request: :environment do
    # selection des requests qui ont besoin d'être expired
    requests = Request.confirmed.merge(Request.need_to_expired)
    i = 0
    requests.each do |request|
      # le ranking est corrige (bug non resolu)
      i == 0 ? ranking = request.ranking : ranking = request.ranking.to_i - i
      # suppression du ranking"
      request.expired!
      request.ranking = 0
      request.save
      i += 1
      # toutes les requetes dont les rangs sont superieur à la request supprimee gagnent une place
      requests_reranking = Request.redorder_ranking(ranking)
      requests_reranking.each do |request|
        request.ranking -= 1
        request.save
      end
      RequestMailer.with(request: request).confirm_expired.deliver_later
    end
  end
end


