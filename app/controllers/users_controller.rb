class UsersController < ApplicationController

  before_action :set_user, except: [:index]
  before_action :authenticate_user!

  def show
    @user = User.find_by_id(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def index
    @users = User.all
  end

  def follow
    current_user.send_follow_request_to(@user)
    @user.accept_follow_request_of(current_user)
    redirect_back(fallback_location: users_path(@user))
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_back(fallback_location: users_path(@user))
  end

  def set_user
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(20)
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following.page(params[:page]).per(20)
  end
end
