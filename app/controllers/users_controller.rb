class UsersController < ApplicationController

  define index
    @users = User.all

    render json: @users
  end

  define show
    @user = User.find(params[:id])

    render json: @user
  end
end
