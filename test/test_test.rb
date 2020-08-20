# frozen_string_literal: true

unless ENV["PRY_TEST_DEMO"]
  require_relative "test_helper"

  class TestTest < PryTest::Test
    before do
      @test_test = TestTest.clone
      @test_test.instance_eval { @subclasses = [] }
      @test_test.instance_eval { @tests = [] }
      @example = Class.new(@test_test) {
        before {}
        after {}
        test("truth") { assert true }
      }
      @before_callback = @example.before
      @after_callback = @example.after
    end

    test "adds subclass" do
      assert @test_test.subclasses.length == 1
      assert @test_test.subclasses[0] == @example
    end

    test "stores subclasses" do
      assert @test_test.subclasses.is_a?(Array)
      assert @test_test.subclasses.length == 1
      assert @test_test.subclasses.first == @example
    end

    test "stores tests" do
      assert @example.tests.is_a?(Array)
      assert @example.tests.length == 1
      assert @example.tests.first.is_a?(PryTest::TestWrapper)
    end

    test ".before" do
      assert @example.instance_eval { @before } == @before_callback
    end

    test ".after" do
      assert @example.instance_eval { @after } == @after_callback
    end

    test "tests" do
      t = lambda {}
      @example.send :test, :add_a_test, &t
      assert @example.tests.length == 2
      assert @example.tests.last.is_a?(PryTest::TestWrapper)
      assert @example.tests.last.desc == :add_a_test
    end
  end
end
