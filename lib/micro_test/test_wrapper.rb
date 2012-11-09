require "observer"

module MicroTest

  # A wrapper class for individual tests.
  # Exists for the purpose of isolating the test method inside of a
  # Celluloid Actor to support asynchronous test runs.
  class TestWrapper
    include Celluloid
    include Observable
    attr_reader :test_class, :desc, :asserts, :duration

    # Constructor.
    # @param [MicroTest::Test] test_class The test class that defines the test being wrapped.
    # @param [String] desc The test description.
    # @yield The block that defines the test code.
    def initialize(test_class, desc, &block)
      @test_class = test_class
      @desc = desc
      create_method(:test, &block)
      reset
    end

    def create_method(name, &block)
      eigen = class << self; self; end
      eigen.send(:define_method, name, &block)
    end

    # callback stubs
    def before; end
    def after; end

    # Runs the test code.
    def invoke
      notify :before_test
      start = Time.now
      before
      test
      after
      @duration = Time.now - start
      notify :after_test
    end

    # A basic assert method to be used within tests.
    #
    # @param [Object] value The value to assert.
    #
    # @example
    #   class SimpleTest < MicroTest::Test
    #     test "common sense" do
    #       assert 1 > 0
    #     end
    #   end
    def assert(value)
      @asserts << assert_info(caller).merge(:value => value)

      if !value
        if MicroTest::Test.options[:pry]
          MicroTest::Test.send :changed
          MicroTest::Test.send :notify_observers, :pry
        end

        if MicroTest::Test.options[:fail_fast]
          MicroTest::Test.send :changed
          MicroTest::Test.send :notify_observers, :fail_fast
        end
      end

      value
    end

    # Indicates if this test has finished running.
    # @return [Boolean]
    def finished?
      !duration.nil?
    end

    # Indicates if this test passed.
    def passed?
      return true if asserts.nil?
      return false if asserts.empty?
      asserts.map{ |a| !!a[:value] }.uniq == [true]
    end

    # Resets this test in preparation for a clean test run.
    def reset
      @asserts = []
      @duration = 0
      delete_observers
    end

    private

    def notify(event)
      changed
      notify_observers(event, self)
    end

    # Builds a Hash of assert information for the given call stack.
    #
    # @param [Array<String>] stack The call stack to extract info from.
    #
    # @example
    #   {
    #     :file_path => "/path/to/test_file.rb",
    #     :line_num => 100,
    #     :line => "  assert 'something' do"
    #   }
    #
    # @return [Hash]
    def assert_info(stack)
      file_path = stack[0][0, stack[0].index(/:[0-9]+:/)]
      lines = MicroTest::Test.files[file_path]
      line_num = line_number(stack, 0)
      line_index = line_num - 1
      line = lines[line_index]
      {
        :file_path => file_path,
        :line_num => line_num,
        :line => line
      }
    end

    # Returns a line number from a call stack.
    # @param [Array<String>] stack The call stack to pull a path from.
    # @param [Integer] index The index of the call stack entry to use.
    # @return [String]
    def line_number(stack, index)
      stack[index].scan(/:[0-9]+:/).first.gsub(/:/, "").to_i
    end

  end
end
