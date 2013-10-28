path = File.expand_path("../micro_test/*.rb", __FILE__)
Dir[path].each { |file| require file }

path = File.expand_path("../micro_test/formatters/*.rb", __FILE__)
Dir[path].each { |file| require file }
