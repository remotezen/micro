class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update,
                                        :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :store_page, only: :index
  
    
   
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
   
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    #debugger
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      #UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url 
    else
      flash[:danger] = "invalid signup"
      render 'new'
    end

  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url(page: session[:page])
  end
  
  def following(*args)
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers(*args)
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page:params[:page])
    render 'show_follow'
  end
  
  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) 
  end


  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation
                                )
  end
 
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
