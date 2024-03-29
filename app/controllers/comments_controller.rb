class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy ]
  before_action :authenticate_user!, except: [:index]
  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/new
  def new
    @comment = current_user.comments.build
  end

  # POST /comments or /comments.json

  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_back(fallback_location: posts_path(@comment.post)) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_back(fallback_location: posts_path(@comment.post)) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: post_path(@post)) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
