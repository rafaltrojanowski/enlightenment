module MultiDomain
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
    before_action :redirect_to_default_domain

    helper_method :current_site
    helper_method :current_domain
    helper_method :current_language
    helper_method :current_language_version
  end

  private

  def current_site
    @current_site ||= current_domain.site
  end

  def current_domain
    @current_domain ||= Domain.lookup(request.host)
  end

  def current_language
    @current_language ||=
        current_site.language_version || LanguageVersion.default.first
  end

  def set_locale
    I18n.locale = current_language.lang_code || I18n.default_local
  end

  alias_method :current_language_version, :current_language

  def redirect_to_default_domain
    if current_site.default_domain != current_domain ||
        request.host != current_domain.domain
      redirect_to_domain(current_site.default_domain)
    end
  end

  def redirect_to_domain(domain)
    uri      = URI.parse(request.url)
    uri.host = domain.domain
    logger.info "Redirecting to: #{uri}"
    redirect_to(uri.to_s)
  end
end
