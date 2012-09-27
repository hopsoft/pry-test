module MicroTest
  class Formatter
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
      info[:asserts].each do |assert|
        if assert[:pass]
          puts green(:PASS)
        else
          puts red(:FAIL)
          puts "  #{red assert[:line]}"
          puts "  #{red assert[:path]}:#{yellow assert[:line_num]}"
        end
      end
    end

    def footer
      puts "\n---"
      puts "Total: #{@total}, Passed: #{green @passed}, Failed: #{red @failed}"
      puts "---"
    end

    private

    def red(text)
      "\e[31m#{text}\e[0m"
    end

    def yellow(text)
      "\e[33m#{text}\e[0m"
    end

    def green(text)
      "\e[32m#{text}\e[0m"
    end

  end
end
