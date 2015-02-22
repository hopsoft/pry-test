require "os"
require "thread"

module PryTest
  class Runner
    class << self
      def terminate
        @terminate = true
      end

      def terminate?
        !!@terminate
      end
    end

    attr_reader :formatter, :options, :duration, :passed, :failed

    def initialize(formatter, options={})
      @formatter = formatter
      @options = options
    end

    def run
      formatter.before_suite(test_classes)
      run_test_classes
      formatter.after_suite(test_classes)
      failed
    end

    def test_classes
      @test_classes ||= PryTest::Test.subclasses.shuffle
    end

    def tests
      @tests ||= test_classes.map{ |klass| klass.tests }.flatten
    end

    def failed_tests
      tests.select{ |test| test.invoked? && !test.passed? }
    end

    def failed
      failed_tests.length
    end

    def passed_tests
      tests.select{ |test| test.invoked? && test.passed? }
    end

    def passed
      passed_tests.length
    end

    private

    def run_test_classes
      start = Time.now
      queue ||= Queue.new if options[:async]
      test_classes.each do |test_class|
        run_test_class test_class, queue
      end
      run_threads(queue) if options[:async]
      @duration = Time.now - start
      formatter.after_results(self)
    end

    def run_test_class(test_class, queue)
      return if PryTest::Runner.terminate?
      formatter.before_class(test_class)
      test_class.tests.shuffle.each do |test|
        if options[:async]
          queue << test
        else
          test.invoke(formatter, options)
        end
      end
      formatter.after_class(test_class)
    end

    def thread_count
      count = OS.cpu_count
      count < 2 ? 2 : count
    end

    def run_threads(queue)
      puts "PryTest is running #{thread_count} threads."
      threads = thread_count.times.map do
        Thread.new do
          while !queue.empty?
            Thread.current.terminate if PryTest::Runner.terminate?
            test = queue.pop
            test.invoke(formatter, options)
          end
        end
      end
      threads.each { |t| t.join }
    end

  end
end
