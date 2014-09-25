begin
  if Rails.env.development?
    ActionMailer::Base.default_url_options[:host] = 'base.dev'

    # MailCatcher
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = { address: 'localhost', port: 1025 }

  elsif Rails.env.production?
    ActionMailer::Base.default_url_options[:host] = 'base.dev'

    # MailCatcher
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = { address: 'localhost', port: 1025 }

  elsif Rails.env.staging?
    raise StandardError, "You need to set up ActionMailer::Base.default_url_options[:host] and other ActionMailer settings for staging environment in #{__FILE__}"

  elsif Rails.env.test?
    ActionMailer::Base.default_url_options[:host] = 'prograils-base.dev'
  else
    fail StandardError, "Not supported environment: #{Rails.env}, check: #{__FILE__}"
  end
end
