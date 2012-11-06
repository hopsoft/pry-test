require "observer"
require "thread"

module MicroTest
  class TestCell
    include Celluloid

    attr_reader :test_class, :desc, :asserts, :duration

    def initialize(test_class, desc, &block)
      @test_class = test_class
      @desc = desc
      @test = block
    end

    def invoke(formatter)
      @formatter = formatter
      start = Time.now
      @test.call
      @duration = Time.now - start
      @asserts = @test_class.asserts[desc]
      @formatter.test self
    end

    def passed?
      return false unless asserts
      asserts.map{ |a| !!a[:value] }.uniq == [true]
    end

  end

  class Test
    class << self

      def subclasses
        @subclasses ||= []
      end

      def tests
        @tests ||= []
      end

      def asserts
        @asserts ||= {}
      end

      def files
        @files ||= {}
      end

      # Holds the state for all performed asserts for this class.
      def asserts
        # mutex around this?
        @asserts ||= {}
      end

      # Resets the state in preparation for a new test run.
      def reset
        # mutex around this?
        tests.clear
        asserts.clear
        subclasses.each { |subclass| subclass.reset }
      end

      def inherited(subclass)
        file_path = caller_path(caller)
        files[file_path] = File.open(file_path).readlines
        subclasses << subclass
      end

      def test(desc, &block)
        tests << TestCell.new(self, desc, &block)
      end

      def assert(value)
        info = assert_info(caller)
        key = info[:test_desc]

        # mutex around this?
        asserts[key] ||= []
        asserts[key] << info.merge(:value => value)
      end

      private

      def assert_info(stack)
        file_path = caller_path(stack)
        lines = MicroTest::Test.files[file_path]
        line_num = caller_line(stack)
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

      def caller_path(stack)
        stack[0][0, stack[0].index(/:[0-9]+:/)]
      end

      def caller_line(stack)
        stack[0].scan(/:[0-9]+:/).first.gsub(/:/, "").to_i
      end

      def test_desc(lines, start)
        reversed = lines[0..start].reverse
        index = reversed.index { |line| line =~ /\Wtest\s/ }
        line = reversed[index]
        line.gsub(/\Wtest\s|\sdo\W|'|"/, "").strip
      end

    end
  end
end
