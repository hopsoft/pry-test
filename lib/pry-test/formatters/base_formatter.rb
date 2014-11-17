module PryTest

  class << self
    def formatters
      @formatters ||= []
    end
  end

  # The base class for formatters.
  # Defines the API that formatters can/should implement
  # to control test run output.
  class BaseFormatter
    attr_accessor :passed, :failed, :duration

    class << self
      def inherited(subclass)
        PryTest.formatters << subclass
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

    def render(template_name, template_context=nil)
      puts text_to_render(template_name, template_context)
    end

    def render_inline(template_name, template_context=nil)
      print text_to_render(template_name, template_context)
    end

    private

    def text_to_render(template_name, template_context=nil)
      Template.new(template_context || self).render_to_string(template_name)
    end

  end
end
