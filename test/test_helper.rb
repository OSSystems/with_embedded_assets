ENV["RAILS_ENV"] = "test"

require "rails"
%w(
  action_controller
  rails/test_unit
  sprockets
).each do |framework|
  require "#{framework}/railtie"
end

FIXTURE_PATH = "#{File.dirname(__FILE__)}/fixtures"
ASSETS_PATHS = ["images",
                "stylesheets",
                "javascripts"].collect{|dir| "#{FIXTURE_PATH}/#{dir}"}
module WithEmbeddedAssetsRailsTest
  class Application < Rails::Application
    config.logger = Logger.new("/dev/null") # no logger
    config.active_support.deprecation = :stderr
    config.assets.enabled = true
    config.assets.paths = ASSETS_PATHS
    config.eager_load = false
    config.active_support.test_order = :sorted
    config.secret_key_base = 'idontcare'
  end
end

require 'with_embedded_assets' # loads the gem code

WithEmbeddedAssetsRailsTest::Application.initialize!
require 'rails/test_help'
