class MicroTest
  class << self
    def inherited(subclass)
      @subclasses ||= []
      @subclasses << subclass
    end

    attr_accessor :passed, :failed

    def reset
      @passed = 0
      @failed = 0
    end

    def tests
      @tests ||= {}
    end

    def run_tests
      reset
      @subclasses.each do |subclass|
        puts subclass.name
        subclass.tests.each do |desc, block|
          puts "  Test #{desc}: "
          block.call
        end
      end
      puts "Passed Asserts: \e[32m#{MicroTest.passed}\e[0m, Failed Asserts: \e[31m#{MicroTest.failed}\e[0m"
    end

    def test(description, &block)
      tests[description] = block
    end

    def assert(value)
      if value
        MicroTest.passed += 1
        puts "    \e[32mPASS\e[0m: #{caller[0]}"
      else
        MicroTest.failed += 1
        puts "    \e[31mFAIL\e[0m: #{caller[0]}"
      end
    end
  end
end

# class ExampleTest < MicroTest
#   test "booleans" do
#     assert true
#     assert false
#   end
# end

# MicroTest.run_tests
