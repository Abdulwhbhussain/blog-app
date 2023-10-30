class ApplicationController < ActionController::Base
  # current_user is a method that returns the currently logged in user
  # Get First User from the database
  # User.first
  before_action :current_user

  def current_user
    @current_user = User.first
  end
end
