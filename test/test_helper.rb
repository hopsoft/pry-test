if ENV["PRY_TEST_DEMO"] != "true"
  require "coveralls"
  Coveralls.wear!
  SimpleCov.command_name "pry-test"
end

require_relative "../lib/pry-test"
