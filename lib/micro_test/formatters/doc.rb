require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def initialize
      @failures = []
    end

    def before_class(test_class)
      puts "\n#{test_class.name}"
    end

    def after_test(test)
      super
      if test.passed?
        puts green("  #{test.desc}")
      else
        test.asserts.each do |assert|
          next if assert[:value]
          @failures << { :test => test, :assert => assert }
          puts red("  #{test.desc} (FAILED - #{@failures.count})")
        end
      end
    end

    def print_failures
      puts
      puts "Failures:"
      puts
      @failures.each_with_index do |failure, idx|
        test = failure[:test]
        assert = failure[:assert]
        puts
        puts "  #{idx + 1}) #{test.test_class.name} #{test.desc}"
        puts red("     Failure/Error: #{assert[:line]}")
        puts cyan("     #{assert[:file_path]}:#{assert[:line_num]}")
      end
    end

    def after_suite(test_classes)
      print_failures if @failures.count > 0
      puts
      msg = "#{MicroTest::Test.all_tests.count} examples, #{@failures.count} failures"
      if @failed > 0
        puts red(msg)
      else
        puts msg
      end
      puts
      super
    end

  end
end
