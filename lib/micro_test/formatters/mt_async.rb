require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def after_test(test)
      test.passed? ? print(green ".") : print(red ".")
    end

    def after_suite(test_classes)
      puts
      print_output_for_test_classes test_classes
      puts
      puts "".ljust(80, "-")
      print " #{passed + failed} Tests finished in #{yellow duration} seconds. "
      totals = []
      totals << green("#{passed} Passed") if passed > 0
      totals << red("#{failed} Failed") if failed > 0
      print "(#{totals.join(", ")})"
      puts
      puts
    end

    private

    def print_output_for_test_classes(test_classes)
      test_classes.each do |test_class|
        puts
        puts test_class.name.ljust(80, "-")
        print_output_for_tests test_class.tests
      end
    end

    def print_output_for_tests(tests)
      tests.each do |test|
        next unless test.finished?
        duration = (test.duration * 10**4).round.to_f / 10**4
        print yellow("  #{duration.to_s.ljust(6, "0")}")

        if test.passed?
          print green(" #{test.desc}")
        else
          print_test_failure test
        end

        puts
      end
    end

    def print_test_failure(test)
      puts red(" #{test.desc}")
      test.failed_asserts.each do |assert|
        print_assert_failure assert
      end
    end

    def print_assert_failure(assert)
      puts
      print "".ljust(9)
      puts "#{assert[:file_path]}:#{red(assert[:line_num])}"
      puts "".ljust(9) + "".rjust(71, "-")
      index = assert[:line_num] - 1
      start = index - 2
      start = 0 if start <= 0
      finish = index + 2
      finish = assert[:lines].length - 1 if finish >= assert[:lines].length
      (start..finish).each do |i|
        print "".ljust(9)
        if i == index
          print red((i + 1).to_s.rjust(3, "0"))
          print red("|")
          print red(assert[:lines][i])
        else
          print (i + 1).to_s.rjust(3, "0")
          print "|"
          print assert[:lines][i]
        end
      end
    end

  end
end
