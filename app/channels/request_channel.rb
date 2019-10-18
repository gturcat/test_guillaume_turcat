class RequestChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'request'
  end

  #  def speak(data)
  #     ActionCable.server.broadcast 'request', message: data.message
  # end

end
