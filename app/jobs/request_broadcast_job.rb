class RequestBroadcastJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast('request', {request: Request.confirmed.count })
  end

  private

    # def render(order)
    #     ApplicationController.renderer.render(partial: 'requests/request', locals: {request: request})
    # end
end
