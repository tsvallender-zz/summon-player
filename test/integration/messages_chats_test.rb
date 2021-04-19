require 'test_helper'

class MessagesChatsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:trevor)
    @bob = users(:bob)
    @chat = chats(:one)
  end

  test "sending a message should update chats updated timestamp" do
    sign_in @user
    assert_changes "@chat.reload.updated_at" do
      post messages_path(params: { message: { 
        text: 'Hello', to_id: @bob.id, chat_id: @chat.id
        }})
      assert_response :success
    end
  end
end
