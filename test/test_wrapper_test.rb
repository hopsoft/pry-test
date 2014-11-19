unless ENV["PRY_TEST_DEMO"]
  require_relative "test_helper"

  class TestWrapperTest < PryTest::Test

    test ".new" do
      desc = "test_#{rand(999**10)}"
      meth = lambda { ".new" }
      t = PryTest::TestWrapper.new(TestWrapperTest, desc, &meth)
      assert t.desc == desc
      assert t.test == ".new"
      assert t.passed?
      assert t.finished? == false
      assert t.duration.nil?
      assert t.asserts.empty?
    end

  end
end
