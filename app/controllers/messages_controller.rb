class MessagesController < ApplicationController

  def new
    @message = Message.new
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    authorize @message
    if @message.save
      redirect_to message_path(@message)
    else
      render 'message/show'
    end
  end

  def show
    @message = Message.find(params[:id])
    authorize @message
  end

  private

  def message_params
    params.require(:message).permit(:to, :body, :subject)
  end

end
