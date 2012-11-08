require "forwardable"

module MicroTest

  # A wrapper class for individual tests.
  # Exists for the purpose of isolating the test method inside of a
  # Celluloid Actor to support asynchronous test runs.
  class TestWrapper
    extend Forwardable
    include Celluloid
    attr_reader :test_class, :desc, :asserts, :duration
    def_delegators :@test_class, :assert

    # Constructor.
    # @param [MicroTest::Test] test_class The test class that defines the test being wrapped.
    # @param [String] desc The test description.
    # @yield The block that defines the test code.
    def initialize(test_class, desc, &block)
      @test_class = test_class
      @desc = desc
      create_method(:test, &block)
    end

    def create_method(name, &block)
      eigen = class << self; self; end
      eigen.send(:define_method, name, &block)
    end

    # callback stubs
    def before; end
    def after; end

    # Runs the test code.
    # @param [MicroTest::Formatter] formatter The formatter used to handle test output.
    def invoke(formatter)
      @formatter = formatter
      @formatter.before_test self
      start = Time.now
      before
      test
      after
      @duration = Time.now - start
      @asserts = @test_class.asserts[desc]
      @formatter.after_test self
    end

    # Indicates if this test has finished running.
    # @return [Boolean]
    def finished?
      !duration.nil?
    end

    # Indicates if this test passed.
    def passed?
      return false unless asserts
      return true if asserts.empty?
      asserts.map{ |a| !!a[:value] }.uniq == [true]
    end

    # Resets this test in preparation for a clean test run.
    def reset
      @asserts = nil
      @duration = nil
    end

  end
end
