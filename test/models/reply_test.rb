require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  def setup
    @user = users(:fred)
    @micropost = microposts(:orange)

    @reply = @user.replies.build(reply: "Lorem ipsum", 
                                 user_id: @user.id, 
                                 micropost_id: @micropost.id)
  end
  test "should be valid" do
    assert @reply.valid?
    
  end
  # test "the truth" do
  #   assert true
  # end
end
