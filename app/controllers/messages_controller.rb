class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    chat = Chat.find(message_params[:chat_id])
    message = chat.messages.build(
      from: current_user,
      text: message_params[:text]
    )

    if message.save
      rendered_message = render_message(message)
      chat.users.each do |u|
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
      params.require(:message).permit(:text, :to_id, :chat_id)
    end

    def render_message(message)
      render(partial: 'message', locals: { message: message })
    end
end
