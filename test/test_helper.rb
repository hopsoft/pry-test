if ENV["PRY_TEST_DEMO"] != "true"
  require "coveralls"
  Coveralls.wear!
end

require_relative "../lib/pry-test"
