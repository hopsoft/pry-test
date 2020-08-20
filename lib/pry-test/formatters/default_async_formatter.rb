# frozen_string_literal: true

require_relative "base_formatter"

module PryTest
  class DefaultAsyncFormatter < PryTest::BaseFormatter
    set_short_name "default_async"

    def after_test(test)
      render_inline "default_async/test", test
    end

    def after_suite(test_classes)
      puts
      test_classes.each do |test_class|
        render_output_for_test_class test_class
      end

      render "default/suite"
    end

    private

    def render_output_for_test_class(test_class)
      render "default/class", test_class
      test_class.tests.each do |test|
        render_output_for_test test
      end
    end

    def render_output_for_test(test)
      return unless test.invoked?

      if test.passed?
        render "default/test_pass", test
      else
        render "default/test_fail", test
      end
    end
  end
end
