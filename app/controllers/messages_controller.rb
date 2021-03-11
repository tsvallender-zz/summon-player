class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    @user = User.find(params[:id])
    @messages = current_user.conversation(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = current_user.sent_messages.build(
      to: User.find(message_params[:to_id]),
      text: message_params[:text]
    )

    if @message.save
        ActionCable.server.broadcast 'messages_channel',
                                    text: @message.text,
                                    to: @message.to,
                                    from: @message.from
    end
    redirect_to messages_path # need to do something meaningful
  end

  private
    def message_params
        params.require(:message).permit(:text, :to_id)
    end
end
