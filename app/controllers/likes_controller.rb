class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(post_id: @post.id, user_id: @user.id)

    respond_to do |format|
      if @like.save
        format.html { redirect_to request.referer }
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
