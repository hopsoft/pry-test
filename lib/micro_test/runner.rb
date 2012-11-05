module MicroTest
  module Runner
    class << self
      attr_reader :options, :current_test

      def update(event, arg)
        send(event, arg) if respond_to?(event)
      end

      def add_test_class(klass)
        test_classes << klass
      end

      def test_classes
        @test_classes ||= []
      end

      def file(path)
        @files ||= {}
        @files[path] ||= File.read(path).split("\n")
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
        @asserts << file_info(caller[6]).merge(:passed => value)
      end

      def run(formatter, opts={})
        @options = opts
        @current_test = nil
        formatter.header

        test_classes.shuffle.each do |test_class|
          formatter.group test_class
          test_class.invoke :before, :all

          test_class.tests.keys.shuffle.each do |desc|
            @current_test = "#{test_class.name} -> test #{desc}"
            @failed = false
            @asserts = []
            test_class.invoke :before, :each
            start = Time.now
            test_class.tests[desc].call
            formatter.test :name => desc, :passed => !@failed, :asserts => @asserts, :duration => Time.now - start
            test_class.invoke :after, :each
          end

          test_class.invoke :after, :all
        end

        formatter.footer
      end

    end
  end
end
