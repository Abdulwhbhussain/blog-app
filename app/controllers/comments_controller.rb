class CommentsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post_id: @post, text: comment_params[:text])

    return unless @comment.save

    redirect_to user_post_path(@post.author, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
