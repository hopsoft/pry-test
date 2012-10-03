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
    end

    def group(name)
    end

    def test(info)
      @total += 1
      info[:passed] ? @passed += 1 : @failed += 1
    end

    def footer
      puts "Tests: #{@total}, Passed: #{green @passed}, Failed: #{red @failed}"
    end

  end
end
