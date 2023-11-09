class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @comments = Comment.where(post_id: params[:post_id])

    render json: @comments
  end

  def show
    @comment = Comment.find(params[:id])

    render json: @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@comment.user, @comment.post)
  end

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post_id: @post.id)
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post_id: @post.id, text: comment_params[:text])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully created.' }

        format.json { render :show, status: :created, location: @comment }

      else
        format.html do
          render :new, status: :unprocessable_entity, locals: { user: @user, post: @post, comment: @comment }
        end

        format.json do
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
