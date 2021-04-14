require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  def setup
    @trevor = users(:trevor)
    @bob = users(:bob)
    @chat = chats(:two)
    @message = messages(:one)
  end

  test "should be valid" do
    assert @chat.valid?
  end

  test "deleting should delete messages" do
    assert_difference "Message.count", -1 do
      Chat.destroy(@chat.id)
    end
  end

  test "deleting should delete user links" do
    assert_difference "ChatUser.count", -2 do
      Chat.destroy(@chat.id)
    end
  end

  test "with_users() should return chat with given users" do
    c = Chat.with_users([@trevor, @bob])
    assert_equal 1, c.id
  end
end
