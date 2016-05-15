class RepliesController < ApplicationController
  def create
    @reply = current_user.replies.build(replies_params)
    if @reply.save
      flash[:success] = "You have spoken"
      redirect_to current_user
    else
      flash[:warning] = "you were unable to speak your mind oh no?"
      redirect_to current_user
    end
  end
  def destroy
  end
  def new
    @micropost = Micropost.find_by(id: params[:micro_id])
    @reply = Reply.new
  end
  private
    def replies_params
      params.require(:reply).permit(:micropost_id,
                                   :reply)
    end
end
