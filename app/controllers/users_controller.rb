class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = User.find(params[:user_id])
    end
  end
end
