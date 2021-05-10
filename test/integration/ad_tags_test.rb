require 'test_helper'

class AdTagsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:trevor)
    @rpg = categories(:rpg)
  end

  test "new ad should create necessary tags, add all" do
    @ad = @user.ads.build(title: "Let's play Forbidden Lands",
      text: "I'd love to play this game'",
      category: @rpg)
    @ad.save
    @ad.addTags(['forbiddenlands', 'fantasy', 'hexcrawl'])

    assert_equal(3, @ad.tags.count)
  end
end
