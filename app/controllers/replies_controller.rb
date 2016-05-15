class RepliesController < ApplicationController
  before_action :followed_user, only: [:new]
  def create
    @reply = current_user.replies.build(replies_params)
    @title = "In response to"
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
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @reply = Reply.new
  end
  private
    def replies_params
      params.require(:reply).permit(:micropost_id,
                                   :reply)
    end
    
    def followed_user
      unless params[:micropost_id].blank?
        micro = params[:micropost_id]
      else
        micro = params[:reply][:micropost_id]
      end

      post = Micropost.find_by(id: micro)
      redirect_to(root_url) unless current_user.following?(post.user)
    end
end
