class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  respond_to :html, :json

  before_action :authenticate_user_from_token!

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
end
