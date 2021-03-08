require 'test_helper'

class AdTest < ActiveSupport::TestCase
  def setup
    @user = users(:trevor)
    @ad = @user.ads.build(title: "D&D Players wanted",
                          text: "I need some people to play D&D with")
  end

  test "should be valid" do
    assert @ad.valid?
  end
end
