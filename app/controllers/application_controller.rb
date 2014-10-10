class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :html, :json

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def current_user_json
    if current_user
      UserSerializer.new(current_user, scope: current_user, root: false).to_json
    else
      {}.to_json
    end
  end
  helper_method :current_user_json


  protected

  def configure_permitted_parameters
    account_update_params = %w(username avatar)
    devise_parameter_sanitizer.for(:account_update) << account_update_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation)
    end
  end

  private

  def layout_by_resource
    if devise_controller? && resource_name == :administrator
      'admin_auth'
    else
      'application'
    end
  end
end
