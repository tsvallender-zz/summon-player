class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    @user = User.find(params[:id])
    @messages = current_user.conversation(params[:id])
    @message = Message.new
  end

  def create
    message = current_user.sent_messages.build(
      to: User.find(message_params[:to_id]),
      text: message_params[:text]
    )
    if message.save
        ActionCable.server.broadcast('messages_channel',
                                    { message: render_message(message) })
    end
  end

  private
    def message_params
        params.require(:message).permit(:text, :to_id)
    end

    def render_message(message)
      render(partial: 'message', locals: { message: message })
    end
end
