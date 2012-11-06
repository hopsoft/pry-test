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
      puts "#{test.test_class.name}  #{test.desc} #{test.asserts.inspect} #{test.duration}\n"
    end

    def footer
      # puts "\n---"
      # puts "Total: #{@total}, Passed: #{green @passed}, Failed: #{red @failed}"
      # puts "---"
    end

  end
end
