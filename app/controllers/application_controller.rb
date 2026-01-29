class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :name ])
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email_address, :introduction, :profile_image ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :email_address, :introduction, :profile_image ])
  end
end
