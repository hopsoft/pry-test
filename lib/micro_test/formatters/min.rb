require File.join(File.dirname(__FILE__), "..", "color")

module MicroTest
  class Formatter
    include MicroTest::Color

    def initialize
      @passed = 0
      @failed = 0
    end

    def header
    end

    def group(name)
    end

    def test(info)
      info[:passed] ? @passed += 1 : @failed += 1
    end

    def footer
      puts "Passed: #{green @passed}, Failed: #{red @failed}"
    end

  end
end
