require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @trevor = users(:trevor)
    @bob = users(:bob)
    @chat = chats(:one)
  end

  test "should redirect when not logged in" do
    get chats_path
    assert_redirected_to new_user_session_path
    get chat_path(@chat)
    assert_redirected_to new_user_session_path
    post chats_path(params: { subject: nil})
    assert_redirected_to new_user_session_path
  end

  test "should get list of chats" do
    sign_in @trevor
    get chats_path
    assert_select "li.chat", 2
    assert_response :success
  end

  test "should show chat" do
    sign_in @trevor
    get chat_path(@chat)
    assert_select "li.message", 2
    assert_response :success
  end

  test "should create new chat" do
    sign_in @bob
    assert_difference "Chat.count", 1 do
      post chats_path(params: { chat: { 
        subject_type: nil, subject_id: nil, participants: 3
        }})
    end
  end
  
  test "shouldn't create new chat if existing" do
    sign_in @trevor
    assert_no_difference "Chat.count" do
      post chats_path(params: { chat: { 
        subject_type: nil, subject_id: nil, participants: 2
        }})
    end
    assert_redirected_to chat_path(1)
  end
end
