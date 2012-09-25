path = File.expand_path(File.join(File.dirname(__FILE__), "micro_test"))
require File.join(path, "test")
require File.join(path, "runner")

MicroTest::Test.add_observer MicroTest::Runner
