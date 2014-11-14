require_relative "lib/color"

module MicroTest

  class << self
    def formatters
      @formatters ||= []
    end
  end

  # The base class for formatters.
  # Defines the API that formatters can/should implement
  # to control test run output.
  class BaseFormatter
    include MicroTest::Color
    attr_accessor :passed, :failed, :duration

    class << self
      def inherited(subclass)
        MicroTest.formatters << subclass
      end

      def short_name
        @short_name || name
      end

      def set_short_name(value)
        @short_name = value
      end
    end

    def initialize
      @duration = 0
      @passed = 0
      @failed = 0
    end

    def before_suite(test_classes)
    end

    def before_class(test_class)
    end

    def before_test(test)
    end

    def after_test(test)
    end

    def after_class(test_class)
    end

    def after_results(runner)
      @duration = runner.duration
      @passed = runner.passed
      @failed = runner.failed
    end

    def after_suite(test_classes)
    end

  end
end
