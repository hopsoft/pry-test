module MicroTest
  module Runner
    def self.test_classes
      @test_classes ||= []
    end

    def self.register_assert(value)
      if value
        puts "   \e[32mPASS\e[0m: #{caller[1]}"
        @passed += 1
      else
        puts "   \e[31mFAIL\e[0m: #{caller[1]}"
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
      puts "Passed Asserts: \e[32m#{@passed}\e[0m, Failed Asserts: \e[31m#{@failed}\e[0m"
    end
  end

  class Test
    def self.inherited(subclass)
      MicroTest::Runner.test_classes << subclass
    end

    def self.tests
      @tests ||= {}
    end

    def self.test(description, &block)
      tests[description] = block
    end

    def self.assert(value)
      MicroTest::Runner.register_assert(value)
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
