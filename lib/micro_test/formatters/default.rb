require File.join(File.dirname(__FILE__), "..", "color")

module MicroTest
  class Formatter
    include MicroTest::Color

    def initialize
      @start = Time.now
    end

    def test_finished(test)
      test.passed? ? print(green ".") : print(red ".")
    end

    def all_finished(test_classes)
      puts
      puts "".ljust(80, "-")
      puts "Awesome summary coming soon!"
      puts "Finished in #{Time.now - @start}"
      puts "".ljust(80, "-")
      puts
    end

  end
end
