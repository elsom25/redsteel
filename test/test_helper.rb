ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride' # awesome colorful output
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  self.use_transactional_fixtures = false # using DatabaseCleaner

  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end
