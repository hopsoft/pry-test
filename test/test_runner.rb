# class TestRunner < MicroTest::Test

#   test "interface" do
#     assert MicroTest::Runner.respond_to?(:current_test)
#     assert MicroTest::Runner.respond_to?(:add_test_class)
#     assert MicroTest::Runner.respond_to?(:test_classes)
#     assert MicroTest::Runner.respond_to?(:file)
#     assert MicroTest::Runner.respond_to?(:file_info)
#     assert MicroTest::Runner.respond_to?(:assert)
#     assert MicroTest::Runner.respond_to?(:run)
#   end

#   test "add_test_class" do
#     t = Class.new(MicroTest::Test)
#     assert MicroTest::Runner.test_classes.include?(t)
#   end

#   test "file" do
#     f = MicroTest::Runner.file(__FILE__)
#     assert f.is_a?(Array)
#   end

#   test "file_info" do
#     info = MicroTest::Runner.file_info caller[0]
#     assert info[:file].is_a?(Array)
#     assert info[:line_num].is_a?(Numeric)
#     assert info[:path] =~ /.*lib\/micro_test\/runner\.rb$/
#     assert info[:line] == "test_class.tests[desc].call"
#   end

#   test "current_test" do
#     assert MicroTest::Runner.current_test == "TestRunner -> test current_test"
#   end

# end
