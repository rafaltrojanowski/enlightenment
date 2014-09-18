class Admin::BaseController < ApplicationController
  before_action :authenticate_administrator!
  skip_before_action :redirect_to_default_domain
  layout 'admin'

  def set_locale
    I18n.locale = :en
  end
end
