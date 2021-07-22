require 'test_helper'

class AdTest < ActiveSupport::TestCase
  def setup
    @user = users(:trevor)
    @rpg = categories(:rpg)
    @ad = @user.ads.build(title: "D&D Players wanted",
                          content: "I need some people to play D&D with",
                          category: @rpg)
  end

  test "should be valid" do
    assert @ad.valid?
  end

  test "should require a title" do
    @ad.title = "     "
    assert_not @ad.valid?
  end

  test "should require a description" do
    @ad.content = "    "
    assert_not @ad.valid?
  end

  test "should require a valid category" do
    @ad.category = nil
    assert_not @ad.valid?
  end

  test "should require an owner" do
    @ad.user = nil
    assert_not @ad.valid?
  end

  test "active scope should not get archived ads" do
    assert_equal(3, Ad.active.count)
  end

  test "archived scope should get only archived ads" do
    assert_equal(1, Ad.archived.count)
  end
end
