require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @tag = tags(:dnd)
  end

  test "should redirect new when not logged in" do
    get new_tag_path
    assert_redirected_to new_user_session_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Tag.count" do
      post tags_path, params: { tag: { name: "test", description: "test tag" }}
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Tag.count" do
      delete tag_path(@tag)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect edit when not logged in" do
    @old = @tag
    assert_equal @old, @tag
    patch tag_path(@tag), params: { tag: { name: "test", description: "test tag" }}
    assert_equal @old, @tag
    assert_redirected_to new_user_session_path
  end
end
