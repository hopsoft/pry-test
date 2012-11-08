require "observer"
require "thread"

module MicroTest

  # Superclass for all test classes.
  # @example Create a subclass with a test.
  #   class SimpleTest < MicroTest::Test
  #     test "common sense" do
  #       assert 1 > 0
  #     end
  #   end
  class Test
    MUTEX = Mutex.new

    class << self
      attr_accessor :options

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

      # All asserts that have been invoked.
      # Each subclass of MicroTest::Test tracks all invoked asserts.
      # Asserts are invoked within tests during test runs.
      # @return [Hash]
      def asserts
        @asserts ||= {}
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
        @options = {}
        asserts.clear
        tests.each { |test| test.reset }
        subclasses.each { |subclass| subclass.reset }
      end

      # A callback provided by Ruby that is invoked whenever a subclass is created.
      def inherited(subclass)
        file_path = path(caller, 0)
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
        info = assert_info(caller)
        key = info[:test_desc]

        MUTEX.synchronize do
          asserts[key] ||= []
          asserts[key] << info.merge(:value => value)
        end

        binding.pry(:quiet => true) if MicroTest::Test.options[:pry] && !value
        value
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
      #     :line => "  assert 'something' do",
      #     :test_desc => 'the test description'
      #   }
      #
      # @return [Hash]
      def assert_info(stack)
        file_path = path(stack, 1)
        lines = MicroTest::Test.files[file_path]
        line_num = line_number(stack, 1)
        line_index = line_num - 1
        line = lines[line_index]
        test_desc = test_desc(lines, line_index)
        {
          :file_path => file_path,
          :line_num => line_num,
          :line => line,
          :test_desc => test_desc
        }
      end

      # Returns a file path from a call stack.
      # @param [Array<String>] stack The call stack to pull a path from.
      # @param [Integer] index The index of the call stack entry to use.
      # @return [String]
      def path(stack, index)
        stack[index][0, stack[index].index(/:[0-9]+:/)]
      end

      # Returns a line number from a call stack.
      # @param [Array<String>] stack The call stack to pull a path from.
      # @param [Integer] index The index of the call stack entry to use.
      # @return [String]
      def line_number(stack, index)
        stack[index].scan(/:[0-9]+:/).first.gsub(/:/, "").to_i
      end

      # Finds the test description within a list of lines.
      # The lines are typically the lines read from a file.
      # @param [Array<String>] lines The lines to find the description in.
      # @param [Integer] start The starting index for the search.
      # @return [String]
      def test_desc(lines, start)
        reversed = lines[0..start].reverse
        index = reversed.index { |line| line =~ /\Wtest\s/ }
        return "unknown test" unless index
        line = reversed[index]
        line.gsub(/\Wtest\s|\sdo\W|'|"/, "").strip
      end

    end
  end
end
