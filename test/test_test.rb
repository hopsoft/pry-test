unless ENV["MT_DEMO"]
  require_relative "test_helper"

  class TestTest < MicroTest::Test

    before do
      @test_test = TestTest.clone
      @test_test.instance_eval { @subclasses = [] }
      @test_test.instance_eval { @tests = [] }
      @Example = Class.new(@test_test) do
        before {}
        after {}
        test("truth") { assert true }
      end
      @before_callback = @Example.before
      @after_callback = @Example.after
    end

    test "adds subclass" do
      assert @test_test.subclasses.length == 1
      assert @test_test.subclasses[0] == @Example
    end

    test "stores subclasses" do
      assert @test_test.subclasses.is_a?(Array)
      assert @test_test.subclasses.length == 1
      assert @test_test.subclasses.first == @Example
    end

    test "stores tests" do
      assert @Example.tests.is_a?(Array)
      assert @Example.tests.length == 1
      assert @Example.tests.first.is_a?(MicroTest::TestWrapper)
    end

    test "stores files" do
      file = __FILE__
      assert @test_test.files[file].is_a?(Array)
      assert @test_test.files[file].select{ |l| l.start_with?("      assert @test_test.files[file].select{ |l| l.start_with?(") }.length > 0
    end

    test ".reset" do
      @Example.tests.first.instance_eval do
        @asserts = nil
        @duration = nil
      end
      @Example.reset
      assert @Example.tests.length == 1
      assert @Example.tests.first.asserts == []
      assert @Example.tests.first.duration == nil
    end

    test ".before" do
      assert @Example.instance_eval { @before } == @before_callback
    end

    test ".after" do
      assert @Example.instance_eval { @after } == @after_callback
    end

    test "tests" do
      t = lambda {}
      @Example.send :test, :add_a_test, &t
      assert @Example.tests.length == 2
      assert @Example.tests.last.is_a?(MicroTest::TestWrapper)
      assert @Example.tests.last.desc == :add_a_test
    end

  end
end
