module MicroTest
  class Runner

    def initialize(formatter, options={})
      @formatter = formatter
      @options = options
    end

    def run
      @formatter.header

      MicroTest::Test.subclasses.shuffle.each do |test_class|
        test_class.tests.shuffle.each do |test|
          test.async.invoke(@formatter)
        end
      end

      @formatter.footer
    end

  end
end
