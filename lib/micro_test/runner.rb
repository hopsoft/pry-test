module MicroTest
  class Runner
    attr_reader :formatter, :options, :active_test

    def initialize(formatter, options={})
      @formatter = formatter
      @options = options
    end

    def run
      MicroTest::Test.reset
      MicroTest::Test.options = @options
      test_classes = MicroTest::Test.subclasses.shuffle
      tests = test_classes.map{ |klass| klass.tests }.flatten
      formatter.before_suite(test_classes)
      start = Time.now

      test_classes.each do |test_class|
        formatter.before_class(test_class)
        if options[:async]
          test_class.tests.shuffle.each do |test|
            exit if @exit
            test.async.invoke(formatter)
          end
        else
          test_class.tests.shuffle.each do |test|
            exit if @exit
            @active_test = test
            test.invoke(formatter)
          end
        end
        formatter.after_class(test_class)
      end

      sleep 0.05 while !finished?(tests)
      formatter.duration = Time.now - start
      formatter.passed = tests.select{ |t| t.passed? }.count
      formatter.failed = tests.select{ |t| !t.passed? }.count
      formatter.after_suite(test_classes)
    end

    def stop
      MicroTest::Test.subclasses.each do |subclass|
        subclass.tests.each { |test| test.terminate unless Celluloid::Actor.current == test }
      end
      sleep 0.1
    end

    # Callback for observing MicroTest::Test
    def update(action)
      case action
      when :pry
        binding.pry(:quiet => true)
      when :fail_fast
        @exit = true
        stop
      end
    end

    private

    def finished?(tests)
      tests.empty? || tests.map{ |t| t.finished? }.uniq == [true]
    end

  end
end
