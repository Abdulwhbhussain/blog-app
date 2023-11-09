class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @posts = Post.where(author_id: params[:user_id])
    @posts = @posts.order(created_at: :desc)
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path
  end

  # use current_user method from application controller to create a new post
  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(@user), notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity, locals: { user: @user, post: @post } }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
