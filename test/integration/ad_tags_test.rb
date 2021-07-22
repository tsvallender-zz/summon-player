require 'test_helper'

class AdTagsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:trevor)
    @rpg = categories(:rpg)
    @dnd = ads(:dnd)
  end

  test "new ad should create necessary tags, add all" do
    @ad = @user.ads.build(title: "Let's play Forbidden Lands",
      content: "I'd love to play this game'",
      category: @rpg)
    @ad.save
    @ad.addTags(['forbiddenlands', 'fantasy', 'hexcrawl'])

    assert_equal(3, @ad.tags.count)
  end

  test "ads should not be allowed more than 10 tags" do
    assert_raise Exception do
      @dnd.addTags(['one', 'two', 'three', 'four', 'five',
                    'six', 'seven', 'eight', 'nine'])
    end
  end
end
