source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'

gem 'pg'

gem 'sass-rails',   '~> 4.0.3'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'ember-rails'
gem 'ember-source', '1.8.0'
gem 'emblem-rails' # Now any templates ending in .emblem will be compiled as Ember-Handlebars templates.

gem 'haml'
gem 'haml-rails'
gem 'inherited_resources'
gem 'simple_form', '>= 3.0.0'
gem 'nested_form', '~> 0.3.2'
gem 'devise', '>= 3.0.0'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'gravatar_image_tag'
gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4.1"
gem 'kaminari'
gem 'configurable_engine'
gem 'friendly_id', '>= 5.0.0'
gem 'dotenv-rails'
gem 'cancancan', '~> 1.9'
gem 'primary'
gem 'pismo', '~> 0.7.4'
gem 'sidekiq'
gem 'jquery-tokeninput-rails'
gem 'select2-rails'
gem 'carrierwave'
gem 'webshot'
gem 'font-awesome-sass'
gem 'autosize-rails'
gem 'fog', github: 'fog/fog'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'tagmanager-rails'

group :development, :test do
  gem 'spring'
  gem 'spring-commands-testunit', require: false
  gem 'minitest-rails', '>= 2.0.0.beta1'
  gem 'factory_girl_rails'
  gem 'guard-minitest', require: false
  gem 'terminal-notifier-guard'

  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'minitest-rails-capybara', '>= 2.0.0.beta1', require: false
  gem 'poltergeist', require: false
  gem 'launchy'
  gem 'simplecov', require: false
  gem 'database_cleaner', require: false
  gem 'vcr', require: false
  gem 'webmock', require: false
end

group :development do
  gem 'capistrano', '~> 2.15.5'

  gem 'awesome_print'
  gem 'annotate', '>= 2.6.0'

  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end
