require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def after_test(test)
      super
      test.passed? ? print(green ".") : print(red ".")
    end

    def after_suite(test_classes)
      super
      puts
      puts "".ljust(80, "-")
      puts "Awesome summary coming soon!"
      puts "Finished in #{duration}"
      puts "".ljust(80, "-")
      puts
    end

  end
end
