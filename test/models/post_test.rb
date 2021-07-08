require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:trevor)
    @group = groups(:dungeon)
    @post = @user.posts.build(content: "Test post",
                              subject: @group)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should require content" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "should require an owner" do
    @post.user = nil
    assert_not @post.valid?
  end
end
