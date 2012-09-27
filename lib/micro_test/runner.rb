require File.expand_path(File.join(File.dirname(__FILE__), "formatter"))

module MicroTest
  module Runner
    class << self

      def update(event, arg)
        send event, arg
      end

      def formatter
        @formatter ||= MicroTest::Formatter.new
      end

      def add_test_class(klass)
        test_classes << klass
      end

      def test_classes
        @test_classes ||= []
      end

      def file(path)
        @files ||= {}
        @files[path] ||= File.open(path, "r").readlines.map { |l| l.gsub(/\n/, "") }
      end

      def file_info(callstack_entry)
        path = callstack_entry[0, callstack_entry.index(/:[0-9]+:/)]
        file = file(path)
        line_num = callstack_entry.scan(/:[0-9]+:/).first.gsub(/:/, "").to_i
        line = file[line_num - 1].strip
        {
          :path => path,
          :file => file,
          :line => line,
          :line_num => line_num
        }
      end

      def assert(value)
        @failed ||= !value
        @asserts << file_info(caller[6]).merge(:pass => value)
      end

      def run(f=nil)
        @formatter = f
        formatter.header

        test_classes.shuffle.each do |test_class|
          formatter.group test_class
          test_class.invoke :before, :all

          test_class.tests.keys.shuffle.each do |desc|
            @failed = false
            @asserts = []
            test_class.invoke :before, :each
            test_class.tests[desc].call
            formatter.test(:name => desc, :passed => !@failed, :asserts => @asserts)
            test_class.invoke :after, :each
          end

          test_class.invoke :after, :all
        end

        formatter.footer
      end

    end
  end
end
