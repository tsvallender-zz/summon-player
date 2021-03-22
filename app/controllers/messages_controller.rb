class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = current_user.conversations
  end

  def show
    @user = User.find_by(username: params[:id])
    @messages = current_user.conversation(@user.id)
    @message = Message.new
  end

  def create
    chat = Chat.find(message_params[:chat_id])
    message = chat.messages.build(
      from: current_user,
      text: message_params[:text]
    )

    if message.save
      ActionCable.server.broadcast(
        "messages_channel_#{chat.id}",
        { message: render_message(message) } )
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
