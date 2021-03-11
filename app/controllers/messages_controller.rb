class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.paginate(page: params[:page])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(
      from: current_user,
      to: message_params[:to],
      text: message_params[:text]
    )

    if @message.save
        flash[:success] = "message posted!"
    end

    render 'new' # need to do something meaningful
  end
end
