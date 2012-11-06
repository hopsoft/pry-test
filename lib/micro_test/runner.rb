module MicroTest
  class Runner

    def initialize(formatter, options={})
      @formatter = formatter
      @options = options
    end

    def run

      MicroTest::Test.reset
      MicroTest::Test.subclasses.shuffle.each do |test_class|
        test_class.tests.shuffle.each do |test|
          test.async.invoke(@formatter)
        end
      end

      # TODO: wait for all tests to complete

    end

  end
end
