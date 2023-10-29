class ApplicationController < ActionController::Base
  # current_user is a method that returns the currently logged in user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
