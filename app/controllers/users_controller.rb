class UsersController < ApplicationController

  before_action :set_user
  before_action :authenticate_user!
  def show
    @posts = Post.all
    @user = User.find_by_id(params[:id])
    @user_id = current_user.id
    @user_avatar = current_user.avatar
  end

  def index
    @users = User.all
  end

  def follow
    current_user.send_follow_request_to(@user)
    @user.accept_follow_request_of(current_user)
    redirect_to users_path(@user)
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to users_path(@user)
  end

  def accept
    current_user.accept_follow_request_of(@user)
    redirect_to users_path(@user)
  end

  def decline
    current_user.decline_follow_request_of(@user)
    redirect_to users_path(@user)
  end

  def cancel
    current_user.remove_follow_request_for(@user)
    redirect_to users_path(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
