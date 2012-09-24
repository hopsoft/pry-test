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
        puts test_class.name
        test_class.tests.each do |desc, block|
          puts "- test #{desc}: "
          block.call
        end
      end
      puts "Passed Asserts: #{green @passed}, Failed Asserts: #{red @failed}"
    end
  end

  class Test
    def self.inherited(subclass)
      MicroTest::Runner.test_classes << subclass
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
#     assert true
#     assert true
#     assert false
#   end
# end

# MicroTest::Runner.run
