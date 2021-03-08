require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = Tag.new(name: "dnd", description: "Dungeons & Dragons")
  end

  test "should be valid" do
    assert @tag.valid?
  end

  test "should require name" do
    @tag.name = "   "
    assert_not @tag.valid?
  end

  test "description should be optional" do
    @tag.description = nil
    assert @tag.valid?
  end
end
