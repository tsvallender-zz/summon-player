require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @trevor = users(:trevor)
    @bob = users(:bob)
  end

  test "should redirect index when not logged in" do
    get messages_index_path
    assert_redirected_to new_user_session_path
  end

  test "should get index when logged in" do
    sign_in @trevor
    get messages_index_path
    assert :success
  end

  test "should redirect conversation when not logged in" do
    get message_path(@trevor)
    assert_redirected_to new_user_session_path
  end

  test "should get conversation when logged in" do
    sign_in @trevor
    get message_path(@bob)
    assert_response :success
  end

  test "should redirect create when not logged in" do
    post messages_path(params: { message: { text: "Hello there", to_id: 1}})
    assert_redirected_to new_user_session_path
  end

  test "should create message when logged in" do
    sign_in @trevor
    assert_difference "Message.count", 1 do
      post messages_path(params: { message: { text: "Hello there", to_id: 1}})
    end
    assert_response :success
  end
end
