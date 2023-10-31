class CommentsController < ApplicationController

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = @current_user

    if @comment.save
      render json: @comment, include: :user, status: :created, location: @comment
    else
      render json: @comment.errors, include: :user, status: :unprocessable_entity
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:text)
    end
end