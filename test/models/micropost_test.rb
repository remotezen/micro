require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:fred)
    @micropost = @user.microposts.build(content: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  test "cotent should be less then 140 characters" do
    string = "A" * 141
    @micropost.content = string
    assert_not @micropost.valid?
  end
  
  test "order should be in reverse order of creation"  do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
