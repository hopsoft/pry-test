module MicroTest
  class Runner
    attr_reader :formatter

    def initialize(formatter, options={})
      @formatter = formatter
      @options = options
    end

    def run
      MicroTest::Test.reset
      test_classes = MicroTest::Test.subclasses.shuffle
      formatter.before_suite(test_classes)

      test_classes.each do |test_class|
        formatter.before_class(test_class)
        test_class.tests.shuffle.each { |t| t.async.invoke(formatter) }
        formatter.after_class(test_class)
      end

      while !MicroTest::Test.finished?
        sleep 0.1
      end

      formatter.all_finished(test_classes)
    end

  end
end
