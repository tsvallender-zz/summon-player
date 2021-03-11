class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    # completely useless, just for dev
    @messages = Message.paginate(page: params[:page])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(
      from: current_user,
      to: User.find(message_params[:to_id]),
      text: message_params[:text]
    )

    if @message.save
        flash[:success] = "message posted!"
    end

    redirect_to messages_path # need to do something meaningful
  end

  private
    def message_params
        params.require(:message).permit(:text, :to_id)
    end
end
