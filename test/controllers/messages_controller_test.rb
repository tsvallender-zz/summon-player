require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @trevor = users(:trevor)
    @bob = users(:bob)
  end

  test "should redirect create when not logged in" do
    post messages_path(params: { message: { text: "Hello there", chat_id: 1}})
    assert_redirected_to new_user_session_path
  end

  test "should create message when logged in" do
    sign_in @trevor
    assert_difference "Message.count", 1 do
      post messages_path(params: { message: { text: "Hello there", chat_id: 1}})
    end
    assert_response :success
  end

  test "sending message with no chat id should make new chat" do
    sign_in @bob
    assert_difference "Chat.count", 1 do
      post messages_path(params: { message: 
        { text: "Test", chat_id: nil, participants: 3 }
      })
    end
  end
end
