require "monitor"

module PryTest

  # A wrapper class for individual tests.
  # Exists for the purpose of isolating the test method so it can run in its own thread.
  class TestWrapper
    include MonitorMixin
    attr_reader :test_class, :desc, :asserts

    # Constructor.
    # @param [PryTest::Test] test_class The test class that defines the test being wrapped.
    # @param [String] desc The test description.
    # @yield The block that defines the test code.
    def initialize(test_class, desc, &block)
      super() # inits MonitorMixin
      @test_class = test_class
      @desc = desc
      create_method(:test, &block)
      reset
    end

    # Creates a method on this instance.
    # @param [Symbol] name The name of the method.
    # @yield The block of code that will serve as the method's implementation.
    def create_method(name, &block)
      eigen = class << self; self; end
      eigen.send(:define_method, name, &block)
    end

    # callback stubs
    def before; end
    def after; end

    # Runs the test code.
    # @formatter [PryTest::Formatter] The formatter to use.
    # @options [Hash]
    def invoke(formatter, options={})
      reset
      @formatter = formatter
      @options = options
      @formatter.before_test(self)
      start = Time.now
      before
      test
      @invoked = true
      after
      @duration = Time.now - start
      @formatter.after_test(self)
    end

    # A basic assert method to be used within tests.
    #
    # @param [Object] value The value to assert.
    #
    # @example
    #   class SimpleTest < PryTest::Test
    #     test "common sense" do
    #       assert 1 > 0
    #     end
    #   end
    def assert(value)
      @asserts << assert_info(caller).merge(:value => value)

      if !value
        Pry.start binding.of_caller(0)

        # I don't really like the coupling to the runner here
        PryTest::Runner.exit = true if @options[:fail_fast]
      end

      value
    end

    # Indicates if this test has finished running.
    # @return [Boolean]
    def finished?
      !@duration.nil?
    end

    # Indicates if this test passed.
    def passed?
      return true if !@invoked || @asserts.empty?
      return false if @asserts.empty?
      @asserts.map{ |a| !!a[:value] }.uniq == [true]
    end

    # Returns a list of all failed asserts.
    def failed_asserts
      return [] if passed?
      @asserts.select { |a| !a[:value] }
    end

    # Resets this test in preparation for a clean test run.
    def reset
      @invoked = false
      @asserts = []
      @duration = nil
    end

    # Rounded duration.
    def duration
      return nil if @duration.nil?
      (@duration * 10**4).ceil.to_f / 10**4
    end

    private

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
      lines = PryTest::Test.files[file_path]
      line_num = line_number(stack, 0)
      line_index = line_num - 1
      line = lines[line_index]
      {
        :file_path => file_path,
        :lines => lines,
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
