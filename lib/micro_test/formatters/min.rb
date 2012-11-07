require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def after_suite(test_classes)
      puts
      puts "Passed: #{green passed_count}"
      puts "Failed: #{red failed_count}"
      super
    end

  end
end
