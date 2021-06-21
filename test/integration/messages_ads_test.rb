require 'test_helper'

class MessagesAdsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:trevor)
    @chat = chats(:one)
    @ad = ads(:dnd)
  end

  test "should get messages from interested parties" do
    assert_equal 1, @ad.interested.count
  end
end
