class CommentsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post_id: @post.id, text: comment_params[:text])

    respond_to do |format|
      format.html { redirect_to request.referer } if @comment.save
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
