require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @group = groups(:dragon)
    @user = users(:trevor)
    @bruenor = users(:bruenor)
  end

  test "should create post when logged in" do
    sign_in @user
    assert_difference "Post.count", 1 do
      post posts_path, params: { post: { 
        content: "This is a test", 
        user_id: @user.id,
        subject_id: @group.id,
        subject_type: @group.class.name }}
    end
  end
end
