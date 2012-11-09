module MicroTest
  class Runner
    attr_reader :formatter, :options, :active_test, :duration, :passed, :failed

    def initialize(formatter, options={})
      @formatter = formatter
      @options = options
      reset
    end

    def run
      test_classes = MicroTest::Test.subclasses.shuffle
      tests = test_classes.map{ |klass| klass.tests }.flatten
      formatter.before_suite(test_classes)
      start = Time.now

      test_classes.each do |test_class|
        formatter.before_class(test_class)
        test_class.tests.shuffle.each do |test|
          test.add_observer(self)
          exit if @exit
          @active_test = test
          if options[:async]
            test.async.invoke(@formatter, @options)
          else
            test.invoke(@formatter, @options)
          end
        end
        formatter.after_class(test_class)
      end

      sleep 0.05 while !finished?(tests)
      @duration = Time.now - start,
      @passed = tests.select{ |t| t.passed? }.count,
      @failed = tests.select{ |t| !t.passed? }.count
      formatter.after_results(self)
      formatter.after_suite(test_classes)
    end

    def stop
      MicroTest::Test.subclasses.each do |subclass|
        subclass.tests.each { |test| test.terminate unless Celluloid::Actor.current == test }
      end
      sleep 0.1
    end

    # Callback for observing MicroTest::Test
    def update(event, context)
      binding.pry
      case action
      when :pry
        binding.pry(:quiet => true)
      when :fail_fast
        @exit = true
        stop
      end
    end

    def reset
      @duration = 0
      @passed = 0
      @failed = 0
    end

    private

    def finished?(tests)
      tests.empty? || tests.map{ |t| t.finished? }.uniq == [true]
    end

  end
end
