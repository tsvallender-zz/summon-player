require "test_helper"

class GroupTest < ActiveSupport::TestCase
  def setup
    @user = users(:trevor)
    @group = @user.groups.build(name: "Test group")
  end

  test "should be valid" do
    assert @group.valid?
  end

  test "should require a name" do
    @group.name = "   "
    assert_not @group.valid?
  end

  test "should require an owner" do
    @group.user = nil
    assert_not @group.valid?
  end
  
  test "default privacy should be open" do
    assert_equal "open", @group.privacy
  end
end
