require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  def setup(*args)
    @user = users(:fred)
    @micropost = microposts(:orange)
    
  end
  test "should have a reply form" do
    get :new, micro_id: @micropost
    assert_select "textarea"
    assert_response :success
    end
  
  test "should not create reply if not following user" do
    log_in_as(@user)
    assert_difference 'Reply.count', 0 do
    post :create,  reply: { reply: "ipsum loquitor", 
                             micropost_id: @micropost.id
                           }
    end
    assert_redirected_to root_url 
  end

  
  test "should create reply" do
    log_in_as(@user)
    assert_difference 'Reply.count', 1 do
    post :create,  reply: { reply: "ipsum loquitor", 
                             micropost_id: @micropost.id
                           }
    end
    assert_redirected_to @user
  end


  test "should get destroy" do
    get :destroy, id: @user.id
    assert_response :success
  end

end
