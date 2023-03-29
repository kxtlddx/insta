class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: [:new, :create]
  # GET /posts or /posts.json
  def index
    if current_user
      @following_users = current_user.following
    @posts = Post.joins(:user).where(users: { id: @following_users.map(&:id) })
                 .order(created_at: :desc)
                 .limit(4)
                 .offset(params[:offset])
      @comment = Comment.new
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.likes.destroy_all
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:description, :user_id, images: [])
  end

end
