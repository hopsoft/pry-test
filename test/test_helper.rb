if !ENV["PRY_TEST_DEMO"].nil?
  require "coveralls"
  Coveralls.wear!
end

require_relative "../lib/pry-test"
