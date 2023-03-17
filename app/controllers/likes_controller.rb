class LikesController < ApplicationController

  def index
    @likes = Like.all
  end
  def create
    @like = Like.find_by(user_id: like_params[:user_id], post_id: like_params[:post_id])
    if @like
      @like.destroy
      flash[:success] = "Like removed"
    else
      @like = Like.new(like_params)
      if @like.save
        flash[:success] = "Like created!"
      else
        flash[:danger] = "Error creating like"
      end
    end
    redirect_back(fallback_location: post_path(@like.post))
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end