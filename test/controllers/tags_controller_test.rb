require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @tag = tags(:dnd)
    @trevor = users(:trevor)
  end

  test "should get show" do
    get tag_path(@tag)
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_tag_path
    assert_redirected_to new_user_session_path
  end

  test "should get new when logged in" do
    sign_in @trevor
    get new_tag_path
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Tag.count" do
      post tags_path, params: { tag: { name: "test", description: "test tag" }}
    end
    assert_redirected_to new_user_session_path
  end

  test "should create tag when logged in" do
    sign_in @trevor
    assert_difference "Tag.count", 1 do
      post tags_path, params: { tag: { name: "test", description: "test tag" }}
    end
  end

  test "should redirect edit when not logged in" do
    get edit_tag_path(@tag)
    assert_redirected_to new_user_session_path
    patch tag_path(@tag), params: { tag: { name: "test", description: "test tag" }}
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_in @trevor
    get edit_tag_path(@tag)
    assert :success
    patch tag_path(@tag), params: { tag: { description: "test tag" }}
    assert_redirected_to tag_path(@tag)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Tag.count" do
      delete tag_path(@tag)
    end
    assert_redirected_to new_user_session_path
  end

  test "should destroy when logged in" do
    sign_in @trevor
    assert_difference "Tag.count", -1 do
      delete tag_path(@tag)
    end
  end

end
