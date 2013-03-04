class MessagesController < ApplicationController
  def index
  end

  def create
    params[:message][:sender_id] = current_user.id
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.create!(params[:message])
  end
end
