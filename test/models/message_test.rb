require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @trevor = users(:trevor)
    @bob = users(:bob)
    @message = messages(:one)
  end

  test "should be valid" do
    assert @message.valid?
  end

  test "should not be valid without from" do
    @message.from = nil
    assert_not @message.valid?
  end

  test "must have some content" do
    @message.text = '    '
    assert_not @message.valid?
  end
end