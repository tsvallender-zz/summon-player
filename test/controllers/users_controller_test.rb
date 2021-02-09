require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:trevor)
  end

  test "should_get_user_profile" do
  	get '/users/'+@user.username
    assert_response :success
	end
end
