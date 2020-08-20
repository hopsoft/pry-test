# frozen_string_literal: true

unless ENV["PRY_TEST_DEMO"]
  require_relative "test_helper"

  class TestWrapperTest < PryTest::Test
    test ".new" do
      desc = "test_#{rand(999**10)}"
      meth = lambda { ".new" }
      t = PryTest::TestWrapper.new(TestWrapperTest, desc, &meth)
      assert t.desc == desc
      assert t.test == ".new"
      assert t.invoked? == false
      assert t.passed? == false
      assert t.duration.nil?
      assert t.asserts.empty?
    end

    test ".assert" do
      assert true
    end

    test ".refute" do
      refute false
    end
  end
end
