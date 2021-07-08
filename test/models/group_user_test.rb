require "test_helper"

class GroupUserTest < ActiveSupport::TestCase
  def setup
    @user = users(:trevor)
    @bruenor = users(:bruenor)
    @group = groups(:dungeon)
    @group_user = @group.group_users.build(user: @bruenor, confirmed: true)
  end

  test "should be valid" do
    assert @group_user.valid?
  end

  test "should require a user" do
    @group_user.user = nil
    assert_not @group.valid?
  end
  
  test "should require a group" do
    @group_user.group = nil
    assert_not @group.valid?
  end
end
