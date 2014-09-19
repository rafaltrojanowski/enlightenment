source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'

gem 'pg'

gem 'sass-rails',   '~> 4.0.3'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'ember-rails'
gem 'ember-source', '1.5.0'
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

gem 'primary'

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
end

group :development do
  gem 'capistrano', '~> 2.15.5'

  gem 'awesome_print'
  gem 'annotate', '>= 2.6.0'

  gem 'quiet_assets'
  gem 'better_errors'
end

group :production do
  gem 'unicorn'
end
