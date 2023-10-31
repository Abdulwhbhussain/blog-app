class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(@post.author, @post), notice: 'Like was successfully created.' }
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
