require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module RedSteel
  class Application < Rails::Application
    config.time_zone = 'Central Time (US & Canada)'
    # TODO Migrate files form -site
    # config.assets.precompile += %w(
    #   modernizr.min.js
    #   feature_tests.js
    #   loading_indicator_ie.js
    #   foundation_setup.js
    # )
  end
end
