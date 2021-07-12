require "test_helper"

class GroupUsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:trevor)
    @ownedgroup = groups(:dungeon)
    @othergroup = groups(:dragon)
  end

  test "should not get index when not logged in" do
    get groups_path
    assert_redirected_to new_user_session_path
  end

  test "should get index" do
    sign_in @user
    get groups_path
    assert_response :success
  end

  test "should update owned group when logged in" do
    sign_in @user
    patch group_path(@ownedgroup), params: { group: {
                                            name: "New group name" } }
    assert_redirected_to group_path(@ownedgroup)
    get group_path(@ownedgroup)
    assert_select "h2.group-name", "New group name"
  end

  test "should not allow update of someone else's group" do
    sign_in @user
    patch group_path(@othergroup), params: { group: {
                                            name: "New group name" } }
    assert_response :unauthorized
    get group_path(@othergroup)
    assert_select "h2.group-name", "The Dragon Group"
  end

  test "should not destroy when not logged in" do
    assert_no_difference "Group.count" do
      delete group_path(@ownedgroup)
    end
  end    

  test "should destroy when logged in" do
    sign_in @user
    assert_difference "Group.count", -1 do
      delete group_path(@ownedgroup)
    end
  end

  test "should not destroy someone else's group" do
    sign_in @user
    assert_no_difference "Group.count" do
      delete group_path(@othergroup)
    end
  end

  # todo test requests, invites
end
