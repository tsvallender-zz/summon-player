require 'test_helper'

class AdTagTest < ActiveSupport::TestCase
  def setup
    @adtag = AdTag.new(ad_id: ads(:dnd).id, tag_id: tags(:dnd).id)
  end

  test "should be valid" do
    assert @adtag.valid?
  end

  test "should require an ad id" do
    @adtag.ad_id = nil
    assert_not @adtag.valid?
  end
  
  test "should require a tag id" do
    @adtag.tag_id = nil
    assert_not @adtag.valid?
  end
end
