require_relative "base_formatter"

module MicroTest
  class DefaultAsyncFormatter < MicroTest::BaseFormatter
    set_short_name "default_async"

    def after_test(test)
      test.passed? ? print(green ".") : print(red ".")
    end

    def after_suite(test_classes)
      puts
      test_classes.each do |test_class|
        print_output_for_test_class test_class
      end
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

    def print_output_for_test_class(test_class)
      puts
      puts test_class.name.ljust(80, "-")
      test_class.tests.each do |test|
        print_output_for_test test
      end
    end

    def print_output_for_test(test)
      return unless test.finished?
      print_duration test.duration

      if test.passed?
        print_test_pass test
      else
        print_test_fail test
      end

      puts
    end

  end
end
