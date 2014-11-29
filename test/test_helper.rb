if ENV["PRY_TEST_DEMO"] != "true"
  require "simplecov"
  require "coveralls"
  #Coveralls.wear!
  SimpleCov.command_name "pry-test"
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter "test/fail_test.rb"
  end
end

require_relative "../lib/pry-test"
