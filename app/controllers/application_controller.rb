class ApplicationController < ActionController::Base
  # current_user is a method that returns the First User from the database
  # This is a temporary solution to the problem of authentication
  # We will learn how to authenticate users later in the course
  def current_user
    @user = User.first
  end
end
