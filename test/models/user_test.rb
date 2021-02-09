require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "test@summonplayer.com",
      username: "tester",
      password: "password"
    )
  end

  test "should be valid" do
    assert @user.valid?
	end

  test "email should exist" do
		@user.email = "      "
    assert_not @user.valid?
  end

  test "username should exist" do
    @user.username = "    "
    assert_not @user.valid?
  end

  test "username shouldn't be too long" do
    @user.username = 'a' * 21
    assert_not @user.valid?
  end

  test "description shouldn't be too long" do
    @user.description = 'a' * 1001
    assert_not @user.valid?
	end
end
