require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @trevor = users(:trevor)
    @bob = users(:bob)
  end

  test "should redirect when not logged in" do
    post chat_path(params: { subject: nil})
    assert_redirected_to new_user_session_path
  end

end
