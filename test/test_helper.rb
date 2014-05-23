ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/pride' # awesome colorful output
require 'minitest/reporters' # fancier output format
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[Rails.root.join('test/support/**/*.rb')].each{ |f| require f }
RedSteel::Application.reload_routes!

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class MiniTest::Spec
  before :each do
    DeferredGarbageCollection.start
  end

  after :each do
    DeferredGarbageCollection.reconsider
  end
end
