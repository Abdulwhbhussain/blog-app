class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :authenticate_user!, unless: :api_request?

  before_action :configure_permitted_parameters, if: :devise_controller?

  # current_user is a method that returns the First User from the database
  # This is a temporary solution to the problem of authentication
  # We will learn how to authenticate users later in the course
  # it will make available user data to all controllers

  # def current_user
  #   User.first
  # end

  protected

  def api_request?
    request.original_url.include?('api')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio])
  end
end
