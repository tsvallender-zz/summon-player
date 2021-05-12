require 'test_helper'

class AdsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @ad = ads(:dnd)
    @bobsad = ads(:scythe)
    @archivedad = ads(:archived)
    @bob = users(:bob)
    @trevor = users(:trevor)
    @category = categories(:rpg)
  end

  test "should get index" do
    get ads_path
    assert_response :success
  end

  test "should get show" do
    get ad_path(@ad)
    assert_response :success
  end

  test "edit and archive ads should be visible on own ads" do
    sign_in @bob
    get ad_path(@bobsad)
    assert_select "a.edit"
    assert_select "a.archive"
  end

  test "edit and archive ads should not be visible on others' ads" do
    sign_in @bob
    get ad_path(@ad)
    assert_select "a.edit", false
    assert_select "a.archive", false
  end

  test "should redirect new when not logged in" do
    get new_ad_path
    assert_redirected_to new_user_session_path
  end

  test "should get new when logged in" do
    sign_in @bob
    get new_ad_path
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Ad.count" do
      post ads_path, params: { ad: { title: "Test ad", text: "Testing", category_id: @category.id, taglist: "dnd"}}
    end
    assert_redirected_to new_user_session_path
  end

  test "should create ad when logged in" do
    sign_in @bob
    assert_difference "Ad.count", 1 do
      post ads_path, params: { ad: { title: "Test ad", text: "Testing", category_id: @category.id, taglist: "dnd"}}
    end
  end

  test "should redirect edit when not logged in" do
    @old = @ad
    assert_equal @old, @ad
    patch ad_path(@ad), params: {ad: { title: "Test ad", text: "Testing", category: @category}}
    assert_equal @old, @ad
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_in @bob
    get edit_ad_path(@bobsad)
    assert_response :success
  end

  test "should redirect edit/update someone elses ad" do
    sign_in @bob
    get edit_ad_path(@ad)
    assert_redirected_to root_path
    @old = @ad
    assert_equal @old, @ad
    patch ad_path(@ad), params: {ad: { title: "Test ad", text: "Testing", category: @category}}
    assert_equal @old, @ad
    assert_redirected_to root_path
  end

  test "should update when logged in" do
    sign_in @bob
    patch ad_path(@bobsad), params: {ad: { title: "Test ad", text: "Testing", category: @category}}
    assert_redirected_to ad_path(@bobsad)
    get ad_path(@bobsad)
    assert_select "h2.ad-title", "Test ad"
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Ad.count" do
      delete ad_path(@ad)
    end
    assert_redirected_to new_user_session_path
  end

  test "should destroy when logged in" do
    sign_in @bob
    assert_difference "Ad.count", -1 do
      delete ad_path(@ad)
    end
  end

  test "should not archive when not logged in" do
    patch archive_ad_path(@ad)
    assert_redirected_to new_user_session_path
    get ad_path(@ad)
    assert_select "div.alert p", 0
  end

  test "should not allow archiving someone elses ad" do
    sign_in @bob
    patch archive_ad_path(@ad)
    assert_redirected_to root_path
    get ad_path(@ad)
    assert_select "div.alert p", 0
  end

  test "should archive own ad" do
    sign_in @bob
    patch archive_ad_path(@bobsad.id)
    assert_redirected_to ad_path(@bobsad)
    get ad_path(@bobsad)
    assert_select "div.alert p", 1
  end

  test "should not unarchive when not logged in" do
    patch unarchive_ad_path(@archivedad)
    assert_redirected_to new_user_session_path
  end

  test "should not allow unarchiving someone elses ad" do
    sign_in @trevor
    patch unarchive_ad_path(@archivedad)
    assert_redirected_to root_path
  end

  test "should unarchive own ad" do
    sign_in @bob
    get ad_path(@archivedad)
    assert_select "div.alert p", 1
    patch unarchive_ad_path(@archivedad.id)
    assert_redirected_to ad_path(@archivedad)
    get ad_path(@archivedad)
    assert_select "div.alert p", 0
  end
end
