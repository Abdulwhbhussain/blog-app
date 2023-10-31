class CommentsController < ApplicationController

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(user_id: @user, text: comment_params[:text])

    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
