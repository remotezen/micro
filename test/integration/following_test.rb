require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup(*args)
    @user = users(:fred)
    log_in_as(@user)
  end
  test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    
  end
end
