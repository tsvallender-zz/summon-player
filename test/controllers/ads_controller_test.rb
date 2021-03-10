require 'test_helper'

class AdsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @ad = ads(:dnd)
    @bob = users(:bob)
    @category = categories(:rpg)
  end

  test "should redirect new when not logged in" do
    get new_ad_path
    assert_redirected_to new_user_session_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Ad.count" do
      post ads_path, params: { ad: { title: "Test ad", text: "Testing", category: @category}}
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Ad.count" do
      delete ad_path(@ad)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect edit when not logged in" do
    @old = @ad
    assert_equal @old, @ad
    patch ad_path(@ad), params: {ad: { title: "Test ad", text: "Testing", category: @category}}
    assert_equal @old, @ad
    assert_redirected_to new_user_session_path
  end

  test "should redirect editing someone elses ad" do
    sign_in @bob
    @old = @ad
    assert_equal @old, @ad
    patch ad_path(@ad), params: {ad: { title: "Test ad", text: "Testing", category: @category}}
    assert_equal @old, @ad
    assert_redirected_to new_user_session_path
  end
end
