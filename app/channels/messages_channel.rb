class MessagesChannel < ApplicationCable::Channel
  def subscribed
    if params[:room] == current_user.username
      stream_from "messages_channel_#{params[:room]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
