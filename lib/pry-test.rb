path = File.expand_path("../pry-test/**/*.rb", __FILE__)
Dir[path].each { |file| require file }
