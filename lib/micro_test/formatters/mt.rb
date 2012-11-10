require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter
    def before_class(test_class)
      puts
      puts test_class.name.ljust(80, "-")
    end

    def after_test(test)
      duration = (test.duration * 10**4).round.to_f / 10**4
      if duration < 0.01
        print yellow("  #{duration.to_s.ljust(6, "0")}")
      else
        print red("  #{duration.to_s.ljust(6, "0")}")
      end

      if test.passed?
        print green(" #{test.desc}")
      else
        print red(" #{test.desc}")
      end

      puts
    end

    def after_suite(test_classes)
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

  end
end
