require "celluloid"
path = File.join(File.dirname(__FILE__), "micro_test", "*.rb")
Dir[path].each { |file| require file }
