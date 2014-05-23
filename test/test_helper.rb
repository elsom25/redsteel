ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride' # awesome colorful output

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
end
