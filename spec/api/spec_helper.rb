ENV["RACK_ENV"] = "test"
require_relative '../../api/app'
raise "database name doesn't contain test" unless DB.opts[:database] =~ /test/

require 'capybara'
require 'capybara/dsl'
require 'rack/test'

Gem.suffix_pattern

require_relative '../minitest_helper'

begin
  require 'refrigerator'
rescue LoadError
else
  Refrigerator.freeze_core
end

App.plugin :not_found do
  raise "404 - File Not Found"
end
App.plugin :error_handler do |e|
  raise e
end

Capybara.app = App.freeze.app

class Minitest::HooksSpec
  include Rack::Test::Methods
  include Capybara::DSL

  def app
    Capybara.app
  end

  after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end