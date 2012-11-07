module MicroTest
  class Runner
    attr_reader :formatter, :options

    def initialize(formatter, options={})
      @formatter = formatter
      @options = options
    end

    def run
      MicroTest::Test.reset
      test_classes = MicroTest::Test.all_subclasses.shuffle
      formatter.before_suite(test_classes)

      test_classes.each do |test_class|
        formatter.before_class(test_class)
        if options[:async]
          test_class.tests.shuffle.each { |t| t.async.invoke(formatter) }
        else
          test_class.tests.shuffle.each { |t| t.invoke(formatter) }
        end
        formatter.after_class(test_class)
      end

      while !MicroTest::Test.all_finished?
        sleep 0.1
      end

      formatter.after_suite(test_classes)
    end

  end
end
