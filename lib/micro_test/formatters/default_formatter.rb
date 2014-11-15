require_relative "base_formatter"

module MicroTest
  class DefaultFormatter < MicroTest::BaseFormatter
    set_short_name "default"

    def before_class(test_class)
      print Template.new(test_class, DefaultHelper).render(:_class)
    end

    def after_test(test)
      if test.passed?
        print Template.new(test, DefaultHelper).render(:_test_pass)
      else
        print Template.new(test, DefaultHelper).render(:_test_fail)
      end

      puts
    end

    def after_suite(test_classes)
      print Template.new(self, DefaultHelper).render(:suite)
    end

  end
end
