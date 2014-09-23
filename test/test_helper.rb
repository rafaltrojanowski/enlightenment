ENV['RAILS_ENV'] = 'test'

require 'simplecov'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'database_cleaner'
require 'capybara/rails'
require 'capybara/rspec/matchers'
require 'minitest/rails/capybara'
require 'capybara/poltergeist'

# Uncomment for awesome colorful output
require 'minitest/pride'

## OVERWRITE CORE CLASSES / DUCK-TYPING
class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Add more helper methods to be used by all tests here...
  class << self
    alias_method :context, :describe
  end
end

## LOAD SUPPORT FILES
Dir[File.expand_path('test/support/*.rb')].each { |file| require file }

## EXTEND TEST CLASSES
class MiniTest::Spec
  TYPES[-1] = [//, ActiveSupport::TestCase] # replace MiniTest::Spec with ActiveSupport::TestCase  (use ActiveSupport::TestCase as default spec type)
end

module MiniTest::Expectations
  infect_an_assertion :assert_redirected_to, :must_redirect_to
  infect_an_assertion :assert_template, :must_render_template
  infect_an_assertion :assert_response, :must_respond_with
end

class ActionController::TestCase
  include Devise::TestHelpers
  include IntegrationHelpers
  include AuthHelpers
end


class Capybara::Rails::Helpers
  # https://github.com/blowmage/minitest-rails-capybara/commit/a7a7dbce7d8bbbd98edfc5edcb32ae8635c931a0
  def default_url_options(options = {})
    { host: 'saas-app.dev' }
  end
end

class Capybara::Rails::TestCase
  include Warden::Test::Helpers
  include IntegrationHelpers
  include AuthHelpers
  before do
    # for some reason minitest-rails-capybara is not doing this...
    Capybara.current_driver = Capybara.javascript_driver if metadata[:js]
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end
  after do
    DatabaseCleaner.clean
    DatabaseCleaner.strategy = :transaction
    Warden.test_reset!
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
  self.use_transactional_fixtures = false
  register_spec_type(/Integration( ?Test)?\z/i, self)
end

## SETTINGS HERE
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, debug: false, phantomjs_logger: WarningSuppressor)
end
Capybara.javascript_driver = :poltergeist
Capybara.always_include_port = true
Capybara.app_host = 'http://app.dev'
DatabaseCleaner.strategy = :transaction

require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.ignore_localhost = true
end
