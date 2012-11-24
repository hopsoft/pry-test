unless ENV["MT_DEMO"]
  class TestTest < MicroTest::Test

    before do
      TestTest.instance_eval { @subclasses = [] }
      TestTest.instance_eval { @tests = [] }
      @Example = Class.new(TestTest) do
        before {}
        after {}
        test("truth") { assert true }
      end
      @before_callback = @Example.before
      @after_callback = @Example.after
    end

    test "adds subclass" do
      assert TestTest.subclasses.length == 1
      assert TestTest.subclasses[0] == @Example
    end

    test "stores subclasses" do
      assert TestTest.subclasses.is_a?(Array)
      assert TestTest.subclasses.length == 1
      assert TestTest.subclasses.first == @Example
    end

    test "stores tests" do
      assert @Example.tests.is_a?(Array)
      assert @Example.tests.length == 1
      assert @Example.tests.first.is_a?(MicroTest::TestWrapper)
    end

    test "stores files" do
      file = __FILE__
      assert TestTest.files[file].is_a?(Array)
      assert TestTest.files[file].select{ |l| l.start_with?("      assert TestTest.files[file].select{ |l| l.start_with?(") }.length > 0
    end

    test ".reset" do
      @Example.tests.first.instance_eval do
        @asserts = nil
        @duration = nil
      end
      @Example.reset
      assert @Example.tests.length == 1
      assert @Example.tests.first.asserts == []
      assert @Example.tests.first.duration == 0
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
