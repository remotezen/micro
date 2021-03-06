class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create(*args)
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |f|
      f.html {redirect_to @user}
      f.js
    end
  end
  
  def destroy(*args)
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |f|
      f.html {redirect_to @user}
      f.js
    end
  end
    
end
