module Api
  module V1
    class UsersController < ApplicationController
      def register
        user = User.new(user_params)

        if user.save
          render json: { message: 'User created successfully' }, status: 200
        else
          render json: { error: user.errors.full_messages }, status: 400
        end
      end

      def login
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          user.api_token = Devise.friendly_token.to_s
          user.save
          render json: { message: 'Login successful', token: user.api_token.to_s }, status: 200
        else
          render json: { message: 'Invalid email or password' }, status: 401
        end
      end

      private

      def user_params
        params.permit(:name, :photo, :bio, :email, :password, :password_confirmation)
      end
    end
  end
end
