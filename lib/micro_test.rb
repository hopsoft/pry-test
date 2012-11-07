require "bundler"
Bundler.require :default
Bundler.require :pry

path = File.join(File.dirname(__FILE__), "micro_test", "*.rb")
Dir[path].each { |file| require file }
