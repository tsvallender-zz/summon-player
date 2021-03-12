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
    user = User.find(message_params[:to_id])
    message = current_user.sent_messages.build(
      to: user,
      text: message_params[:text]
    )

    unless message_params[:ad_id].blank?
      message.ad = Ad.find(message_params[:ad_id])
    end

    if message.save!
        ActionCable.server.broadcast('messages_channel',
                                    { message: render_message(message) })
    else
      flash[:alert] = "Couldn't post your message"
      redirect_to message_path(user.username)
    end
  end

  private
    def message_params
        params.require(:message).permit(:text, :to_id, :ad_id)
    end

    def render_message(message)
      render(partial: 'message', locals: { message: message })
    end
end
