class MessagesController < ApplicationController
  include ParamsHelper
  include ChatHelper

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
      text: message_params[:text],
      ad_id: message_params[:ad_id] ? message_params[:ad_id] : nil
    )

    if message.save && message_params[:ad_id]
      redirect_to chat_path(chat)
      return
    end
    
    if message.save!
      # rendered_message = render_message(message)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
            locals: {message: message })
        end
        format.html do
          render_message(message)
        end
      end
      chat.users.each do |u|
        ActionCable.server.broadcast(
          "messages_channel_#{u.username}",
          { type: 'message', message: message } )
      end
    else
      flash[:alert] = "Couldn't post your message"
      redirect_to chat_path(chat)
    end
  end

  private
    def message_params
      params.require(:message).permit(:text, :to_id, :chat_id, :participants, :ad_id)
      # participants is only used if creating a chat (e.g. from ad)
      # ad_id only used from an ad
    end

    def render_message(message)
      render(partial: 'message', locals: { message: message })
    end
end
