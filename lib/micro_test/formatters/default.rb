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
      puts "Testing in progress...\n\n"
    end

    def group(name)
      puts name
    end

    def test(info)
      @total += 1
      info[:passed] ? @passed += 1 : @failed += 1
      print "- #{info[:name]} "
      if info[:passed]
        puts green(:PASS)
      else
        if info[:error]
          puts "#{red :ERROR} #{red info[:error].message}"
          puts "  #{red info[:error].backtrace[0]}"
        else
          puts red(:FAIL)
          info[:asserts].each do |assert|
            next if assert[:passed]
            puts "  #{red assert[:line]}"
            puts "  #{red assert[:path]}:#{yellow assert[:line_num]}"
          end
        end
      end
    end

    def footer
      puts "\n---"
      puts "Total: #{@total}, Passed: #{green @passed}, Failed: #{red @failed}"
      puts "---"
    end

  end
end
