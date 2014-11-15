require_relative "base_formatter"

module MicroTest
  class DefaultFormatter < MicroTest::BaseFormatter
    set_short_name "default"

    def before_class(test_class)
      render "default/class", test_class
    end

    def after_test(test)
      if test.passed?
        render "default/test_pass", test
      else
        render "default/test_fail", test
      end
    end

    def after_suite(test_classes)
      render "default/suite"
    end

  end
end
