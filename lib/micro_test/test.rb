module MicroTest

  # Superclass for all test classes.
  # @example Create a subclass with a test.
  #   class SimpleTest < MicroTest::Test
  #     test "common sense" do
  #       assert 1 > 0
  #     end
  #   end
  class Test
    class << self

      # All subclasses of this class.
      # @return [Array<MicroTest::Test>]
      def subclasses
        @subclasses ||= []
      end

      # All individual tests defined in this class.
      # @return [Array<MicroTest::TestWrapper>]
      def tests
        @tests ||= []
      end

      # All files that define subclasses of this class.
      # @note Primarily used in the context of MicroTest::Test.
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

      def before(&block)
        @before = block
      end

      def after(&block)
        @after = block
      end

      # Defines a test.
      # Allows subclasses to define tests in their class definition.
      #
      # @param [String] desc A description for the test.
      # @yield A block that defines the test code.
      #
      # @example
      #   class SimpleTest < MicroTest::Test
      #     test "common sense" do
      #       assert 1 > 0
      #     end
      #   end
      def test(desc, &block)
        wrapper = MicroTest::TestWrapper.new(self, desc, &block)
        wrapper.create_method(:before, &@before) if @before
        wrapper.create_method(:after, &@after) if @after
        tests << wrapper
      end

    end
  end
end
