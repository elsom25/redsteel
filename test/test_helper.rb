ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/pride' # awesome colorful output
require 'minitest/reporters' # fancier output format
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new # enable for detailed output

require 'capybara/rails' # integration tests
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
# For tests that require JS:
#   setup do
#     Capybara.current_driver = Capybara.javascript_driver # :selenium by default
#   end

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[Rails.root.join('test/support/**/*.rb')].each{ |f| require f }
RedSteel::Application.reload_routes!

# Capybara
class ActionDispatch::IntegrationTest
  include Capybara::DSL
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

# Devise
class ActionController::TestCase
  include Devise::TestHelpers
end

# MiniTest optimizations
class MiniTest::Spec
  before{ DeferredGarbageCollection.start }
  after{ DeferredGarbageCollection.reconsider }
end
