class MessagesController < ApplicationController
  include ParamsHelper

  before_action :authenticate_user!

  def create
    # If no chat id, see if we need a new chat
    if message_params[:chat_id].empty?
      users = helpers.parse_participants(message_params[:participants])
      if Chat.with_users(users)
        chat = Chat.with_users(users)
      else
        chat = Chat.new(subject: nil)
        chat.users = users
        chat.save
      end
    else
      chat = Chat.find(message_params[:chat_id])
    end

    message = chat.messages.build(
      from: current_user,
      text: message_params[:text]
    )
    
    if message_params[:participants]
      # redirect if coming from an ad
      redirect_to chat_path(chat)
    elsif message.save
      rendered_message = render_message(message)
      helpers.other_users(chat).each do |u|
        ActionCable.server.broadcast(
          "messages_channel_#{u.username}",
          { type: 'message', message: rendered_message } )
      end
    else
      flash[:alert] = "Couldn't post your message"
      redirect_to chat_path(chat)
    end


  end

  private
    def message_params
      params.require(:message).permit(:text, :to_id, :chat_id, :participants)
      # participants is only used if creating a chat
    end

    def render_message(message)
      render(partial: 'message', locals: { message: message })
    end
end
