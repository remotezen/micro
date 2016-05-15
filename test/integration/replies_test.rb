require 'test_helper'

class RepliesTest < ActionDispatch::IntegrationTest
  
  def setup(*args)
    @user = users(:fred)
    @micropost = microposts(:orange)
  end
  
  test "should have a reply form" do
    get replying_path(@micropost.id)
    assert_select "textarea"
    assert_select "title" , "In response to | Micro Application"
    assert_response :success
  end
end
