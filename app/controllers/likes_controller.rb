class LikesController < ApplicationController

  # POST /likes
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(user: @user, post: @post)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_posts_path(@user), notice: 'Like was successfully created.' }
      else
        format.html { redirect_to user_posts_path(@user), notice: 'Like was not created.' }
      end
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end