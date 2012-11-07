require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def after_test(test)
      super
      test.passed? ? print(green ".") : print(red ".")
    end

    def after_suite(test_classes)
      puts
      puts
      puts "Awesome summary coming soon!"
      super
    end

  end
end
