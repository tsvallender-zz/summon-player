class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = current_user.chats
  end

  def show
    # Check if there's an existing chat, otherwise make a new one
    if @chat = current_user.chats.find(params[:id])
      @users = @chat.users.where.not(id: current_user.id)
    else 
      redirect_to chats_path(method: 'post', params: { 
        chat: { participants: user } })
    end
    @message = Message.new
  end

  def create
    chat = Chat.new(subject: chat_params[:subject])

    if chat_params[:participants].respond_to? :each
      chat_params[:participants].each do |p|
        chat.users << User.find(p)
      end
    else
      chat.users << User.find(chat_params[:participants].to_i)
    end
    chat.users << current_user

    if chat.save
      redirect_to chat_path(chat)
    else
      flash[:alert] = "Couldn't start a new conversation"
      redirect_to root_path(user.username)
    end
  end

  private
    def chat_params 
      params.require(:chat).permit(:subject_type, :subject_id, :participants)
    end
end
