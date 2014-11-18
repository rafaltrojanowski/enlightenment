class ApplicationController < ActionController::Base
  serialization_scope :view_context
  protect_from_forgery
  layout :layout_by_resource
  respond_to :html, :json

  before_action :authenticate_user_from_token!
  before_action :configure_permitted_parameters, if: :devise_controller?
  private

  def layout_by_resource
    if devise_controller? && resource_name == :administrator
      'admin_auth'
    else
      'application'
    end
  end

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:user_email].presence
      user       = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :username, :avatar, :avatar_cache, :current_password, :password, :password_confirmation) }
  end
end
