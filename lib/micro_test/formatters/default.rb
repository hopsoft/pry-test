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
      puts white(name)
    end

    def test(info)
      @total += 1
      info[:passed] ? @passed += 1 : @failed += 1
      duration = (info[:duration] * 10**4).round.to_f / 10**4
      msg = "#{info[:name]} ".ljust(60, ".") + duration.to_s
      if info[:passed]
        puts "  #{green(:PASS)} #{msg}"
      else
        if info[:error]
          puts msg
          puts "#{red :ERROR} #{red info[:error].message}"
          puts "  #{red info[:error].backtrace[0]}"
        else
          puts "  #{red(:FAIL)} #{msg}"
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
