require File.join(File.dirname(__FILE__), "formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def initialize
      @start = Time.now
    end

    def after_test(test)
      test.passed? ? print(green ".") : print(red ".")
    end

    def after_suite(test_classes)
      puts
      puts "".ljust(80, "-")
      puts "Awesome summary coming soon!"
      puts "Finished in #{Time.now - @start}"
      puts "".ljust(80, "-")
      puts
    end

  end
end
