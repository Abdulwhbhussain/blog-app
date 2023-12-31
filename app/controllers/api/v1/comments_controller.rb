module Api
  module V1
    class CommentsController < ApplicationController
      def index
        if request.headers['X-AUTH-TOKEN']
          @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
          @post = Post.find(params[:post_id])
          @comments = @post.comments
          render json: { success: true, message: 'Loaded all comments', data: { comments: @comments } }, status: :ok
        else
          respond_to do |format|
            format.json { render json: 'please sign in or add the token'.to_json, status: :ok }
          end
        end
      end

      def create
        if request.headers['X-AUTH-TOKEN']
          @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
          new_comment = @user.comments.new(text: params[:text])
          new_comment.post_id = params[:post_id].to_i
          if new_comment.save
            render json: { success: true, message: 'Comment created', data: { comment: new_comment } }, status: :created
          else
            render json: { success: false, errors: new_comment.errors }, status: :unprocessable_entity
          end
        else
          respond_to do |format|
            format.json { render json: 'please sign in or add the token', status: :ok }
          end
        end
      end
    end
  end
end
