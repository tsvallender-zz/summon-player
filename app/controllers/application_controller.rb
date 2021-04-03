class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :set_user

  protected
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :description, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :description, :email, :password, :current_password)}
    end

  private
    def set_user
      cookies[:username] = current_user.username || nil
    end
end
