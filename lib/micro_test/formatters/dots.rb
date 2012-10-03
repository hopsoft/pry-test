require File.join(File.dirname(__FILE__), "..", "color")

module MicroTest
  class Formatter
    include MicroTest::Color

    def initialize
    end

    def header
    end

    def group(name)
    end

    def test(info)
      if info[:passed]
        print green(".")
      else
        print red("x")
      end
    end

    def footer
      puts
    end

  end
end
