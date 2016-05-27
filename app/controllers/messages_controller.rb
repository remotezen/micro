class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def create
    @message = Message.create!(message_params)
    PrivatePub.publish_to("/messages/1", message: @message)
  end
  private
  def message_params
    params.require(:message).permit(:content)
  end
end
