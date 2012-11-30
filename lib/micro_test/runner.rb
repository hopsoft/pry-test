require "os"
require "thread"

module MicroTest
  class Runner
    class << self
      attr_accessor :exit
    end

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
          @active_test = test
          if @options[:async]
            @tests ||= Queue.new
            @tests << test
          else
            test.invoke(@formatter, @options)
          end
        end
        formatter.after_class(test_class)
      end

      run_threads if @options[:async]

      @duration = Time.now - start
      @passed = tests.select{ |test| test.passed? }.count
      @failed = tests.select{ |test| !test.passed? }.count
      formatter.after_results(self)
      formatter.after_suite(test_classes)
    end

    def reset
      @duration = 0
      @passed = 0
      @failed = 0
    end

    protected

    def run_threads
      threads = []
      thread_count = OS.cpu_count
      thread_count = 2 if thread_count < 2
      puts "MicroTest is running #{thread_count} threads."
      thread_count.times do
        threads << Thread.new do
          while @tests.empty? == false
            Thread.current.kill if MicroTest::Runner.exit
            @tests.pop.invoke(@formatter, @options)
          end
        end
      end
      threads.each { |t| t.join }
    end

  end
end
