class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(post_id: @post.id, user_id: @user.id)

    respond_to do |format|
      format.html { redirect_to request.referer } if @like.save
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
