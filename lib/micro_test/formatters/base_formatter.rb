require "thread"
require File.join(File.dirname(__FILE__), "..", "color")

module MicroTest

  # The base class for formatters.
  # Defines the API that formatters can/should implement
  # to control test run output.
  class BaseFormatter
    include MicroTest::Color
    attr_reader :passed, :failed, :duration

    def before_suite(test_classes)
      @mutex = Mutex.new
      @duration = 0
      @passed = 0
      @failed = 0
      @start = Time.now
    end

    def before_class(test_class)
    end

    def before_test(test)
    end

    def after_test(test)
      @mutex.synchronize do
        if test.passed?
          @passed += 1
        else
          @failed += 1
        end
      end
    end

    def after_class(test_class)
    end

    def after_suite(test_classes)
      @duration = Time.now - @start
      puts
      puts "".ljust(80, "-")
      puts "Finished in #{duration} seconds."
      puts
    end

    def total
      passed + failed
    end
  end

end
