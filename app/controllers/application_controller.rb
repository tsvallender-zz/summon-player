class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :update_allowed_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    root_path
  end

  protected
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { 
        |u| u.permit(:username, 
                     :description,
                     :dob,
                     :email,
                     :password,
                     :password_confirmation)}
      devise_parameter_sanitizer.permit(:account_update) { 
        |u| u.permit(:username, 
                     :description,
                     :email,
                     :password,
                     :password_confirmation,
                     :current_password,
                     :image)}
    end
end
