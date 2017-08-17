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
      @asserts = []
      create_method(:test, &block)
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
      @formatter = formatter
      @options = options
      @formatter.before_test(self)
      start = Time.now
      before
      test
      @invoked = true
      @duration = Time.now - start
      after
      @formatter.after_test(self) unless asserts.empty?
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
      info = assert_info(value, caller_locations.first)
      asserts << info.merge(:value => value)

      if !value
        Pry.start unless @options[:disable_pry]

        # TODO: I don't really like the coupling to the runner here
        PryTest::Runner.terminate if @options[:fail_fast]
      end

      value
    end

    # A basic refute method to be used within tests.
    #
    # @param [Object] value The value to refute.
    #
    # @example
    #   class SimpleTest < PryTest::Test
    #     test "common sense" do
    #       refute 0 > 1
    #     end
    #   end
    def refute(value)
      assert !value
    end

    # Indicates if this test has been invoked.
    # @return [Boolean]
    def invoked?
      !!@invoked
    end

    # Indicates if this test passed.
    def passed?
      return false unless invoked?
      return true if asserts.empty?
      asserts.map{ |a| !!a[:value] }.uniq == [true]
    end

    # Returns a list of all failed asserts.
    def failed_asserts
      asserts.select { |a| !a[:value] }
    end

    # Rounded duration.
    def duration
      return nil if @duration.nil?
      (@duration * 10**4).ceil.to_f / 10**4
    end

    private

    # Builds a Hash of assert information for the given assert value & call stack location.
    #
    # @params [Boolean] value The value of assert.
    # @param [Thread::Backtrace::Location] location The call stack location to extract info from.
    #
    # @example
    #   {
    #     :file_path => "/path/to/test_file.rb",
    #     :line_num => 100,
    #     :line => "  assert 'something' do"
    #   }
    #
    # @return [Hash]
    def assert_info(value, location)
      info = {
        :file_path => location.absolute_path,
        :line_num  => location.lineno
      }

      info.merge! line_info(location) unless value
      info
    end

    # Builds a Hash of line/source information for the given call stack location.
    #
    # @param [Thread::Backtrace::Location] location The call stack location to extract info from.
    #
    # @example
    #   {
    #     :lines => ["line one", "line two"]
    #     :line => "line two"
    #   }
    #
    # @return [Hash]
    def line_info(location)
      lines = File.open(location.absolute_path).readlines
      {
        :lines => lines,
        :line  => lines[location.lineno]
      }
    end

  end
end
