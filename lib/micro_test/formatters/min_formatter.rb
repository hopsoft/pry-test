require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class MinFormatter < MicroTest::BaseFormatter
    set_short_name "min"

    def after_suite(test_classes)
      puts
      puts "Passed: #{green passed}"
      puts "Failed: #{red failed}"
      puts "".ljust(80, "-")
      puts "Finished in #{duration} seconds."
      puts
    end

  end
end
