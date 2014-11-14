require_relative "base_formatter"
require_relative "default_printer"

module MicroTest
  class DefaultFormatter < MicroTest::BaseFormatter
    include DefaultPrinter
    set_short_name "default"

    def before_class(test_class)
      puts
      print_with_line test_class.name
    end

    def after_test(test)
      if test.passed?
        print_test_pass test
      else
        print_test_fail test
      end

      puts
    end

    def after_suite(test_classes)
      puts
      print_line
      print_totals
      puts " in #{yellow duration} seconds."
      print_line
      puts
      puts
    end

    private

    def print_totals
      totals = []
      totals << green("#{passed} Passed") if passed > 0
      totals << red("#{failed} Failed") if failed > 0
      print totals.join(", ")
    end

  end
end
