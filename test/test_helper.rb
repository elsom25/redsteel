ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride' # awesome colorful output
require File.expand_path('../support/factory_girl', __FILE__)

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end

class ActionController::TestCase
  include Devise::TestHelpers
end

