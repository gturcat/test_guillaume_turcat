namespace :request do
  desc "Send reconfirmation mail"
  task confirm_again: :environment do
    requests = Request.confirmed.merge(Request.old)
    requests.each do |request|
      RequestMailer.with(request: request).reconfirmation.deliver_now
    end
  end
end

namespace :request do
  desc "Send reconfirmation mai"
  task expired_request: :environment do
    # selection des request acceptee qui ont besoin d'être expired
    requests = Request.confirmed.merge(Request.need_to_expired)
    requests.each do |request|
      puts "#{request.id} expired"
      # toutes les requetes dont les rang sont superieur à la request supprimee gagne un place
      ranking = request.ranking
      request_reranking = Request.redorder_ranking(ranking)
      request_reranking.each do |request|
        request.ranking -= 1
        request.save
        RequestMailer.with(request: request).confirm_expired.deliver_now
      end
      #suppression du ranking"
      request.ranking = nil
      request.expired!
    end
  end
end


