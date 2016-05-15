class RepliesController < ApplicationController
  def create
  end
  def destroy
  end
  def new
    @reply = Reply.new
  end
end
