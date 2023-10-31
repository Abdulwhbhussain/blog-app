class CommentsController < ApplicationController
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
      else
        format.html do
          render :new, status: :unprocessable_entity, locals: { user: @user, post: @post, comment: @comment }
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
