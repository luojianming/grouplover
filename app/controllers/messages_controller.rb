class MessagesController < ApplicationController
  def index
  end

  def create
    @conversation = Conversation.find(params[:message][:conversation_id])
    @message = @conversation.messages.create!(params[:message])
  end
end
