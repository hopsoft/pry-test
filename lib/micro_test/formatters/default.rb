require File.join(File.dirname(__FILE__), "..", "color")

module MicroTest
  class Formatter
    include MicroTest::Color

    def initialize
      @total = 0
      @passed = 0
      @failed = 0
    end

    def header
      # puts "Testing in progress...\n\n"
    end

    def test(test)
      msg = []
      msg << (test.passed? ? green(:PASS) : red(:FAIL))
      msg << test.test_class.name
      msg << test.desc
      msg << test.duration.to_s + " secs"
      puts msg.join(" ")
    end

    def footer
      # puts "\n---"
      # puts "Total: #{@total}, Passed: #{green @passed}, Failed: #{red @failed}"
      # puts "---"
    end

  end
end
