class RepliesController < ApplicationController
  def create
    #@reply = micropost.build
  end
  def destroy
  end
  def new
    @micropost = Micropost.find_by(id: params[:micro_id])
    @reply = Reply.new
  end
end
