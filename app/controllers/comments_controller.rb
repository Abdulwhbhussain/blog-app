class CommentsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(post_id: @post.id, user_id: @user.id, text: comment_params[:text])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to request.referer }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
