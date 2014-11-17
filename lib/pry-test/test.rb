module PryTest

  # Superclass for all test classes.
  # @example Create a subclass with a test.
  #   class SimpleTest < PryTest::Test
  #     test "common sense" do
  #       assert 1 > 0
  #     end
  #   end
  class Test
    class << self

      # All subclasses of this class.
      # @return [Array<PryTest::Test>]
      def subclasses
        @subclasses ||= []
      end

      # All individual tests defined in this class.
      # @return [Array<PryTest::TestWrapper>]
      def tests
        @tests ||= []
      end

      # All files that define subclasses of this class.
      # @note Primarily used in the context of PryTest::Test.
      # @example Files are stored in a Hash with the following format.
      #   {
      #     "path/to/file1.rb" => ["line 1", "line 2", "line 3", ...],
      #     "path/to/file2.rb" => ["line 1", "line 2", "line 3", ...]
      #   }
      # @return [Hash]
      def files
        @files ||= {}
      end

      # Resets the state in preparation for a new test run.
      def reset
        tests.each { |test| test.reset }
        subclasses.each { |subclass| subclass.reset }
      end

      # A callback provided by Ruby that is invoked whenever a subclass is created.
      def inherited(subclass)
        file_path = caller[0][0, caller[0].index(/:[0-9]+:/)]
        files[file_path] = File.open(file_path).readlines
        subclasses << subclass
      end

      # Defines a setup method that will run before each individual test.
      # @param [Symbol] what Deprecated but maintained for backwards compatibility.
      # @yield A block of code that will serve as the setup method.
      def before(what=nil, &block)
        @before = block
      end

      # Defines a teardown method that will run after each individual test.
      # @param [Symbol] what Deprecated but maintained for backwards compatibility.
      # @yield A block of code that will serve as the teardown method.
      def after(what=nil, &block)
        @after = block
      end

      # Defines a test.
      # Allows subclasses to define tests in their class definition.
      #
      # @param [String] desc A description for the test.
      # @yield A block that defines the test code.
      #
      # @example
      #   class SimpleTest < PryTest::Test
      #     test "common sense" do
      #       assert 1 > 0
      #     end
      #   end
      def test(desc, &block)
        wrapper = PryTest::TestWrapper.new(self, desc, &block)
        wrapper.create_method(:before, &@before) if @before
        wrapper.create_method(:after, &@after) if @after
        tests << wrapper
      end

    end
  end
end
