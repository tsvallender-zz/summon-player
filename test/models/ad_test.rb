require 'test_helper'

class AdTest < ActiveSupport::TestCase
  def setup
    @user = users(:trevor)
    @ad = @user.ads.build(title: "D&D Players wanted",
                          text: "I need some people to play D&D with",
                          category: 'rpg')
  end

  test "should be valid" do
    assert @ad.valid?
  end

  test "should require a title" do
    @ad.title = "     "
    assert_not @ad.valid?
  end

  test "should require a description" do
    @ad.text = "    "
    assert_not @ad.valid?
  end

  test "should require a valid category" do
    assert_raise(Exception) { @ad.category = "blah" }
  end
end
