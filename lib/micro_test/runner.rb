module MicroTest
  module Runner
    class << self

      def red(text)
        "\e[31m#{text}\e[0m"
      end

      def green(text)
        "\e[32m#{text}\e[0m"
      end

      def update(event, arg)
        send event, arg
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
        line = file[line_num - 1]
        {
          :path => path,
          :file => file,
          :line => line,
          :line_num => line_num
        }
      end

      def assert(value)
        info = file_info(caller[6])
        if value
          puts "   #{green :PASS}: #{info[:line]}"
          @passed += 1
        else
          puts "   #{red :FAIL}: #{red info[:line]}"
          puts "         #{info[:path]}:#{info[:line_num]}"
          @failed += 1
        end
      end

      def run
        @passed = @failed = 0
        @test_classes.shuffle.each do |test_class|
          before = test_class.callbacks[:before]
          after = test_class.callbacks[:after]

          puts test_class.name
          before[:all].call if before[:all]
          test_class.tests.keys.shuffle.each do |desc|
            before[:each].call if before[:each]
            puts "- test #{desc}"
            test_class.tests[desc].call
            after[:each].call if after[:each]
          end
          after[:all].call if after[:all]
        end
        puts "---"
        puts "Passed: #{green @passed}, Failed: #{red @failed}"
        puts "---"
      end

    end
  end
end
