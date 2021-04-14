class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = current_user.chats.order("updated_at DESC")
    @chat_users = ChatUser.where(user_id: current_user.id)
  end

  def show
    if @chat = current_user.chats.find(params[:id])
      @users = @chat.users.where.not(id: current_user.id)
    end
    @message = Message.new

    cu = ChatUser.find_by(user_id: current_user.id, chat_id: @chat.id)
    cu.touch(:last_read)
  end

  def create
    users = parse_participants(chat_params[:participants])
    if Chat.with_users(users)
      redirect_to chat_path(Chat.with_users(users))
    else
      chat = Chat.new(subject: chat_params[:subject])

      if chat.save
        redirect_to chat_path(chat)
      else
        flash[:alert] = "Couldn't start a new conversation"
        redirect_to root_path(user.username)
      end
    end
  end

  private
    def chat_params 
      params.require(:chat).permit(:subject_type, :subject_id, :participants)
    end

    def parse_participants(param)
      participants = Array.new
      if param.respond_to? :each
        param.each do |p|
          participants << User.find(p.to_i)
        end
      else
        participants << User.find(param.to_i)
      end
      participants << current_user
    end
end
