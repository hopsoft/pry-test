module MicroTest
  module Runner

    def self.red(text)
      "\e[31m#{text}\e[0m"
    end

    def self.green(text)
      "\e[32m#{text}\e[0m"
    end

    def self.test_classes
      @test_classes ||= []
    end

    def self.log(value)
      if value
        puts "   #{green :PASS} #{caller[1]}"
        @passed += 1
      else
        puts "   #{red :FAIL} #{caller[1]}"
        @failed += 1
      end
    end

    def self.run
      @passed = @failed = 0
      test_classes.each do |test_class|
        before = test_class.callbacks[:before]
        after = test_class.callbacks[:after]

        puts test_class.name
        before[:all].call if before[:all]
        test_class.tests.each do |desc, block|
          before[:each].call if before[:each]
          puts "- test #{desc}: "
          block.call
          after[:each].call if after[:each]
        end
        after[:all].call if after[:all]
      end
      puts "Passed Asserts: #{green @passed}, Failed Asserts: #{red @failed}"
    end
  end

  class Test
    def self.inherited(subclass)
      MicroTest::Runner.test_classes << subclass
    end

    def self.callbacks
      @callbacks ||= { :before => {}, :after => {} }
    end

    def self.before(what, &block)
      callbacks[:before][what] = block
    end

    def self.after(what, &block)
      callbacks[:after][what] = block
    end

    def self.tests
      @tests ||= {}
    end

    def self.test(desc, &block)
      tests[desc] = block
    end

    def self.assert(value)
      MicroTest::Runner.log(value)
    end
  end
end

# class ExampleTest < MicroTest::Test
#   test "booleans" do
#     assert 1 == 1
#     assert true
#     assert false
#   end
# end

# MicroTest::Runner.run
