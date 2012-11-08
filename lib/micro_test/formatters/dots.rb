require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def after_test(test)
      print(test.passed? ? green(".") : red("."))
    end

    def after_suite(test_classes)
      puts
      puts "".ljust(80, "-")
      puts "Finished in #{duration} seconds."
      puts
    end

  end
end
